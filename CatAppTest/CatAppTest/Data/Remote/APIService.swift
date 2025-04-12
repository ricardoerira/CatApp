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

    func fetch<T: Decodable>(_ type: T.Type, from endpoint: String) -> AnyPublisher<T, ServiceError> {
        guard let url = URL(string: baseURL + endpoint) else {
            return Fail(error: ServiceError.badRequest).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"

        return session
            .dataTaskPublisher(for: request)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw ServiceError.invalidResponse
                }

                switch httpResponse.statusCode {
                case 200...299:
                    return result.data
                case 400:
                    throw ServiceError.badRequest
                case 401:
                    throw ServiceError.unauthorized
                case 403:
                    throw ServiceError.forbidden
                case 404:
                    throw ServiceError.notFound
                case 500...599:
                    throw ServiceError.serverError(statusCode: httpResponse.statusCode)
                default:
                    throw ServiceError.unknown(statusCode: httpResponse.statusCode)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let apiError = error as? ServiceError {
                    return apiError
                } else if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                    return ServiceError.noInternet
                } else if let decodingError = error as? DecodingError {
                    print("Decoding error: \(decodingError)")
                    return .invalidResponse
                } else {
                    let code = (error as NSError).code
                    return .unknown(statusCode: code)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}

