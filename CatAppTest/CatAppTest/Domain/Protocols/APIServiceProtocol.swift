//
//  APIServiceProtocol.swift
//  CatAppTest
//
//  Created by andres on 5/04/25.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error>
}
