//
//  APIServiceProtocol.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 5/04/25.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error>
}
