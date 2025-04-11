//
//  Error.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import Foundation

enum APIError: LocalizedError {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError(statusCode: Int)
    case unknown(statusCode: Int)
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .badRequest:
            return "Bad Request (400)."
        case .unauthorized:
            return "Unauthorized. Please check your API key."
        case .forbidden:
            return "Access forbidden."
        case .notFound:
            return "Resource not found."
        case .serverError(let code):
            return "Server error (\(code))."
        case .unknown(let code):
            return "Unexpected error (\(code))."
        case .invalidResponse:
            return "Invalid response from server."
        }
    }
}

enum OfflineServiceError: Error, LocalizedError {
    case unsupportedType
    case typeCastingError
    case coreDataError(Error)
    case noDataAvailable

    var errorDescription: String? {
        switch self {
        case .unsupportedType:
            return "The requested type is not supported."
        case .typeCastingError:
            return "Failed to cast the fetched data to the expected type."
        case .coreDataError(let error):
            return "Core Data fetch failed with error: \(error.localizedDescription)"
        case .noDataAvailable:
                   return "No data available in local storage. Please connect to internet to create data"
        }
    }
}
