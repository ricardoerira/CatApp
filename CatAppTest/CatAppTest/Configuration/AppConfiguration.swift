//
//  AppConfiguration.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 5/04/25.
//

import Foundation
enum AppEnvironment {
    case development
    case staging
    case production
}

final class AppConfiguration {
    static let shared = AppConfiguration()

    private init() {}

    let currentEnvironment: AppEnvironment = .development

    var baseURL: String {
        switch currentEnvironment {
        case .development:
            return "https://api.thecatapi.com/v1"
        case .staging:
            return "https://staging.api.thecatapi.com/v1"
        case .production:
            return "https://api.thecatapi.com/v1"
        }
    }

    var apiKey: String {
        switch currentEnvironment {
        case .development:
            return "live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr"
        case .staging:
            return "live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr"
        case .production:
            return "live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr"
        }
    }
}
