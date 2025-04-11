//
//  CatAPIService.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import Foundation
import Combine

final class APIService: APIServiceProtocol {
    private let baseURL = AppConfiguration.shared.baseURL
    private let apiKey = AppConfiguration.shared.apiKey
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, Error> {
        guard let url = URL(string: baseURL + endpoint) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        return session
            .dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                if let httpResponse = result.response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        return result.data
                    case 400:
                        throw APIError.badRequest
                    case 401:
                        throw APIError.unauthorized
                    case 403:
                        throw APIError.forbidden
                    case 404:
                        throw APIError.notFound
                    case 500...599:
                        throw APIError.serverError(statusCode: httpResponse.statusCode)
                    default:
                        throw APIError.unknown(statusCode: httpResponse.statusCode)
                    }
                } else {
                    throw APIError.invalidResponse
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

