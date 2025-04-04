//
//  CatAPIService.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation

class CatAPIService {
    static let shared = CatAPIService()
    private init() {}

    func fetchBreeds() async throws -> [CatBreed] {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([CatBreed].self, from: data)
    }
}
