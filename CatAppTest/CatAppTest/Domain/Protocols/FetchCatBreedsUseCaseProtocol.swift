//
//  FetchCatBreedsUseCase.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 8/04/25.
//

import Foundation
import Combine

protocol FetchCatBreedsUseCaseProtocol {
    func execute() -> AnyPublisher<[CatBreed], Error>
}
