//
//  FetchCatBreedsUseCase.swift
//  CatAppTest
//
//  Created by andres on 8/04/25.
//

import Foundation
import Combine

protocol FetchCatBreedsUseCaseProtocol {
    func execute() -> AnyPublisher<[CatBreed], Error>
}
