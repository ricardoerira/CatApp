//
//  BreedListViewModellTest.swift
//  CatAppTestTests
//
//  Created by andres on 4/04/25.
//

import XCTest
import Combine
@testable import CatAppTest

final class BreedListViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func test_fetchBreeds_success_setsLoadedState() {
        let expectedBreeds = CatBreed.preview()
        let mockService = MockAPIService(result: .success(expectedBreeds))
        let viewModel = BreedListViewModel(service: mockService)

        let expectation = XCTestExpectation(description: "Should load successfully")

        viewModel.$state
            .dropFirst() // skip initial .idle
            .sink { state in
                if case .loaded(let breeds) = state {
                    // Then
                    XCTAssertEqual(breeds.count, expectedBreeds.count)
                    XCTAssertEqual(breeds.first?.name, expectedBreeds.first?.name)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    func test_fetchBreeds_failure_setsFailedState() {
        let error = URLError(.notConnectedToInternet)
        let mockService = MockAPIService(result: .failure(error))
        let viewModel = BreedListViewModel(service: mockService)

        let expectation = XCTestExpectation(description: "Should fail with error")

        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .failed(let err) = state {
                    XCTAssertEqual((err as? URLError)?.code, error.code)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }

    
    func test_filters_withSearchText_filtersCorrectly() {
        let expectation = XCTestExpectation(description: "Debounced search works")
        let breeds = CatBreed.preview()

        let mockService = MockAPIService(result: .success(breeds))
        let viewModel = BreedListViewModel(service: mockService)
        viewModel.setupSearch()
        viewModel.searchText = "Beng"

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            XCTAssertEqual(viewModel.filteredBreeds.count, 1)
            XCTAssertEqual(viewModel.filteredBreeds.first?.name, "Bengal")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_filterBreeds_filtersCorrectly() {
        let breeds = CatBreed.preview()

        let mockService = MockAPIService(result: .success(breeds))
        let viewModel = BreedListViewModel(service: mockService)
        viewModel.state = .loaded(breeds.map(CatBreedMapper.map))

        viewModel.filterBreeds(with: "Aby")

        XCTAssertEqual(viewModel.filteredBreeds.count, 1)
        XCTAssertEqual(viewModel.filteredBreeds.first?.name, "Abyssinian")
    }
}
