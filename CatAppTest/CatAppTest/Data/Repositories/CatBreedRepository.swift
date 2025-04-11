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
    let offlineService: APIServiceOfflineProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(remoteService: APIServiceProtocol, offlineService: APIServiceOfflineProtocol) {
        self.remoteService = remoteService
        self.offlineService = offlineService
    }
    
    func getCatBreeds() -> AnyPublisher<[CatBreed], Error> {
        remoteService.fetch([CatBreed].self, from: "/breeds")
            .handleEvents(receiveOutput: { [weak self] breeds in
                self?.offlineService.save(item: breeds)
            })
            .catch { error -> AnyPublisher<[CatBreed], Error> in
                
                print("Failed to fetch cat breeds from remote: \(error.localizedDescription)")
                return self.offlineService.fetch([CatBreed].self)
            }
            .eraseToAnyPublisher()
    }
}
