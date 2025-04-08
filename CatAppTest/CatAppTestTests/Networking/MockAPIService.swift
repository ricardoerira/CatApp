//
//  MockAPIService.swift
//  CatAppTestTests
//
//  Created by andres on 4/04/25.
//
import Foundation
import Combine
@testable import CatAppTest

class MockAPIService: APIServiceProtocol {
    var result: Result<[CatBreed], Error>

    init(result: Result<[CatBreed], Error>) {
        self.result = result
    }

    func fetch<T>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error> where T : Decodable {
        switch result {
        case .success(let breeds):
            return Just(breeds as! T)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
