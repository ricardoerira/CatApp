//
//  FetchCatBreedsUseCaseImpl.swift
//  CatAppTest
//
//  Created by andres on 8/04/25.
//

import Foundation
import Combine

final class FetchCatBreedsUseCase: FetchCatBreedsUseCaseProtocol {
    private let repository: CatBreedRepositoryProtocol

    init(repository: CatBreedRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[CatBreed], Error> {
        repository.getCatBreeds()
    }
}
