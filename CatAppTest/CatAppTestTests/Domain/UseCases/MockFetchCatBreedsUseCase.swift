//
//  MockFetchCatBreedsUseCase.swift
//  CatAppTestTests
//
//  Created by Wilson Ricardo Erira  on 10/04/25.
//

import Foundation
import Combine
@testable import CatAppTest

class MockFetchCatBreedsUseCase: FetchCatBreedsUseCaseProtocol {
    var result: Result<[CatBreed], ServiceError> = .success([])

    func execute() -> AnyPublisher<[CatBreed], ServiceError> {
        result.publisher.eraseToAnyPublisher()
    }
}
