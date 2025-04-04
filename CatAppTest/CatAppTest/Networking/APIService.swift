//
//  CatAPIService.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error>
}

final class APIService: APIServiceProtocol {
    private let baseURL = "https://api.thecatapi.com/v1"
    private let session: URLSession
    private let apiKey = "live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr"

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: baseURL + endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

