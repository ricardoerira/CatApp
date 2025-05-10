//
//  BreedListViewModellTest.swift
//  CatAppTestTests
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//
import XCTest
import Combine
@testable import CatAppTest

final class CatBreedListViewModelTests: XCTestCase {
    var viewModel: CatBreedListViewModel!
    var mockUseCase: MockFetchCatBreedsUseCase!
    var cancellables: Set<AnyCancellable>!
    let breeds = CatBreed.preview()


    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchCatBreedsUseCase()
        viewModel = CatBreedListViewModel(fetchCatBreedsUseCase: mockUseCase)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchBreeds_SuccessfulResponse() {
        let expectedBreeds = breeds
        mockUseCase.result = .success(expectedBreeds)
        viewModel.fetchBreeds()

        // Then
        let expectation = self.expectation(description: "Wait for fetch")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.breeds.count, expectedBreeds.count)
            XCTAssertEqual(self.viewModel.filteredBreeds.count, expectedBreeds.count)
            if case .loaded(let breeds) = self.viewModel.state {
                XCTAssertEqual(breeds.count, expectedBreeds.count)
            } else {
                XCTFail("Expected loaded state")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchBreeds_FailureResponse() {
        let expectedError = ServiceError.invalidResponse
        mockUseCase.result = .failure(expectedError)
        viewModel.fetchBreeds()
        let expectation = self.expectation(description: "Wait for error state")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if case .failed(let error) = self.viewModel.state {
                XCTAssertEqual(error.errorDescription,  ServiceError.invalidResponse.errorDescription)
            } else {
                XCTFail("Expected failed state")
            }
            XCTAssertEqual(self.viewModel.errorMessage, expectedError.errorDescription)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchFiltersBreeds() {
        mockUseCase.result = .success(breeds)
        viewModel.fetchBreeds()

        let expectation = self.expectation(description: "Wait for search")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.searchText = "ben"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.filteredBreeds.count, 1)
            XCTAssertEqual(self.viewModel.filteredBreeds.first?.name, "Bengal")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSearchFiltersBreeds_NoMatch() {
        let breeds = CatBreed.preview()
        mockUseCase.result = .success(breeds)
        viewModel.fetchBreeds()

        let expectation = self.expectation(description: "Search yields no results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.searchText = "test"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertTrue(self.viewModel.filteredBreeds.isEmpty, "Expected no breeds to match search")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

}
