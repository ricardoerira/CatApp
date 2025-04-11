//
//  MockCatBreedListViewModel.swift
//  CatAppTestTests
//
//  Created by Wilson Ricardo Erira  on 11/04/25.
//

import Foundation
import Combine

@MainActor
final class MockCatBreedListViewModel: CatBreedListViewModel {
    override init(fetchCatBreedsUseCase: FetchCatBreedsUseCaseProtocol = MockFetchCatBreedsUseCase()) {
        super.init(fetchCatBreedsUseCase: fetchCatBreedsUseCase)
    }

    static var loading: MockCatBreedListViewModel {
        let vm = MockCatBreedListViewModel()
        vm.state = .loading
        return vm
    }

    static var loaded: MockCatBreedListViewModel {
        let vm = MockCatBreedListViewModel()
        vm.state = .loaded(CatBreedModel.preview)
        vm.breeds = CatBreedModel.preview
        vm.filteredBreeds = CatBreedModel.preview
        return vm
    }

    static var error: MockCatBreedListViewModel {
        let vm = MockCatBreedListViewModel()
        vm.state = .failed(NSError(domain: "Test", code: 404, userInfo: [NSLocalizedDescriptionKey: "Mock error"]))
        return vm
    }
}

final class MockFetchCatBreedsUseCase: FetchCatBreedsUseCaseProtocol {
    func execute() -> AnyPublisher<[CatBreed], Error> {
        Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
