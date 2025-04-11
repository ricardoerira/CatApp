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
    var result: Result<[CatBreed], Error> = .success([])

    func execute() -> AnyPublisher<[CatBreed], Error> {
        result.publisher.eraseToAnyPublisher()
    }
}
