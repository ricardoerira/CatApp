//
//  CatBreedServiceProtocol.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 7/04/25.
//

import Foundation
import Combine

protocol CoreDataServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, ServiceError>
    func save<T: Decodable>(item: [T])
}
