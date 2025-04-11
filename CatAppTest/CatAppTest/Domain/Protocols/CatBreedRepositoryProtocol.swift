//
//  CatBreedRepositoryProtocol.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 7/04/25.
//

import Foundation
import Combine

protocol CatBreedRepositoryProtocol {
    func getCatBreeds() -> AnyPublisher<[CatBreed], Error>
}
