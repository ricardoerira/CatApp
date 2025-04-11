//
//  Previews.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import Foundation

extension CatBreed {
    static func preview() -> [CatBreed] {
        return [
            CatBreed(
                id: "abys",
                name: "Abyssinian",
                temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                origin: "Egypt",
                countryCode: "EG",
                description: "The Abyssinian is easy to care for, and a joy to have in your home.",
                intelligence: 5, adaptability: 5,
                referenceImageId: "0XYvRd7oD"
            ),
            CatBreed(
                id: "beng",
                name: "Bengal",
                temperament: "Alert, Agile, Energetic, Demanding, Intelligent",
                origin: "United States",
                countryCode: "US",
                description: "Bengals are a lot of fun to live with, but they're definitely not the cat for everyone.",
                intelligence: 5, adaptability: 5,
                referenceImageId: "O3btzLlsO"
            )
        ]
    }
}
