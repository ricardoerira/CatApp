//
//  Error.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import Foundation

import Foundation

enum ServiceError: LocalizedError {
    case badRequest
    case noInternet
    case unauthorized
    case forbidden
    case notFound
    case serverError(statusCode: Int)
    case unknown(statusCode: Int)
    case invalidResponse
    case unsupportedType
    case typeCastingError
    case coreDataError(Error)
    case noDataAvailable
    
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return NSLocalizedString("error_bad_request", comment: "400 Bad Request")
        case .badRequest:
            return NSLocalizedString("error_bad_request", comment: "400 Bad Request")
        case .unauthorized:
            return NSLocalizedString("error_unauthorized", comment: "401 Unauthorized")
        case .forbidden:
            return NSLocalizedString("error_forbidden", comment: "403 Forbidden")
        case .notFound:
            return NSLocalizedString("error_not_found", comment: "404 Not Found")
        case .serverError(let code):
            return String(format: NSLocalizedString("error_server", comment: "Server error"), code)
        case .unknown(let code):
            return String(format: NSLocalizedString("error_unknown", comment: "Unknown error"), code)
        case .invalidResponse:
            return NSLocalizedString("error_invalid_response", comment: "Invalid Response")
        case .unsupportedType:
            return NSLocalizedString("error_unsupported_type", comment: "Unsupported type")
        case .typeCastingError:
            return NSLocalizedString("error_cast_failed", comment: "Type casting failed")
        case .coreDataError(let error):
            return String(format: NSLocalizedString("error_core_data", comment: "Core Data error"), error.localizedDescription)
        case .noDataAvailable:
            return NSLocalizedString("error_no_data", comment: "No local data available")
        }
    }
}
