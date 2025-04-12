//
//  MockAPIService.swift
//  CatAppTestTests
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//
import Foundation
import Combine
@testable import CatAppTest

class MockAPIService: APIServiceProtocol {
    var result: Result<[CatBreed], ServiceError>

    init(result: Result<[CatBreed], ServiceError>) {
        self.result = result
    }

    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, ServiceError> {
        switch result {
        case .success(let breeds):
            guard let value = breeds as? T else {
                return Fail(error: ServiceError.invalidResponse)
                    .eraseToAnyPublisher()
            }
            return Just(value)
                .setFailureType(to: ServiceError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
