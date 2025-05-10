//
//  CatBreedRepository.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 7/04/25.
//

import Foundation
import Combine

class CatBreedRepository: CatBreedRepositoryProtocol {
    let remoteService: APIServiceProtocol
    let offlineService: CoreDataServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(remoteService: APIServiceProtocol, offlineService: CoreDataServiceProtocol) {
        self.remoteService = remoteService
        self.offlineService = offlineService
    }
    
    func getCatBreeds() -> AnyPublisher<[CatBreed], ServiceError> {
        remoteService
            .fetch([CatBreed].self, from: "/breeds")
            .handleEvents(receiveOutput: { [weak self] breeds in
                self?.offlineService.save(item: breeds)
            })
            .catch { [weak self] remoteError in
                return self?.offlineService.fetch([CatBreed].self)
                ?? Fail(error: ServiceError.noDataAvailable).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
