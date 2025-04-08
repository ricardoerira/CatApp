//
//  APIServiceOffline.swift
//  CatAppTest
//
//  Created by andres on 7/04/25.
//
import Foundation
import CoreData
import Combine

final class OfflineService: APIServiceOfflineProtocol {
    private let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func fetch<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        guard T.self == [CatBreed].self else {
            return Fail(error: OfflineServiceError.unsupportedType).eraseToAnyPublisher()
        }

        let request: NSFetchRequest<CatBreedEntity> = CatBreedEntity.fetchRequest()
        let context = persistentContainer.viewContext

        return Future<T, Error> { promise in
            do {
                let entities = try context.fetch(request)
                guard !entities.isEmpty else {
                    promise(.failure(OfflineServiceError.noDataAvailable))
                    return
                }
                let breeds = entities.map { CatBreed(from: $0) }
                if let result = breeds as? T {
                    promise(.success(result))
                } else {
                    promise(.failure(OfflineServiceError.typeCastingError))
                }
            } catch {
                promise(.failure(OfflineServiceError.coreDataError(error)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save<T: Decodable>(item todos: [T]) {
        guard let breeds = todos as? [CatBreed] else { return }

        let context = persistentContainer.newBackgroundContext()
        context.performAndWait {
            do {
                let request: NSFetchRequest<CatBreedEntity> = CatBreedEntity.fetchRequest()
                let existingEntities = try context.fetch(request)
                let existingIds = Set(existingEntities.compactMap { $0.id })

                for breed in breeds where !existingIds.contains(breed.id) {
                    let entity = CatBreedEntity(context: context)
                    entity.id = breed.id
                    entity.name = breed.name
                    entity.origin = breed.origin
                    entity.countryCode = breed.countryCode
                    entity.breedDescription = breed.description
                    entity.temperament = breed.temperament
                    entity.intelligence = Int16(breed.intelligence)
                    entity.referenceImageId = breed.referenceImageId
                }

                try context.save()
            } catch {
                print(" Failed to save CatBreed entities: \(error)")
            }
        }
    }
}
