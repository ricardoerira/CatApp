//
//  CatBreedServiceProtocol.swift
//  CatAppTest
//
//  Created by andres on 7/04/25.
//

import Foundation
import Combine

protocol APIServiceOfflineProtocol {
    func fetch<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error>
    func save<T: Decodable>(item: [T])
}
