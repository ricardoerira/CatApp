//
//  Preview.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 11/04/25.
//

import Foundation
import Foundation

extension CatBreedModel {
    static var preview: [CatBreedModel] {
        [
            CatBreedModel(
                id: "beng",
                name: "Bengal",
                description: "The Bengal cat is a highly active and intelligent breed with a wild appearance.",
                origin: "United States",
                intelligence: 5,
                adaptability: 4,
                imageURL: URL(string: "https://cdn2.thecatapi.com/images/beng.jpg"),
                countryCode: "US",
                flagEmoji: "🇺🇸"
            ),
            CatBreedModel(
                id: "sphy",
                name: "Sphynx",
                description: "Known for its hairless appearance, the Sphynx is a friendly and energetic breed.",
                origin: "Canada",
                intelligence: 4,
                adaptability: 5,
                imageURL: URL(string: "https://cdn2.thecatapi.com/images/sph.jpg"),
                countryCode: "CA",
                flagEmoji: "🇨🇦"
            ),
            CatBreedModel(
                id: "abys",
                name: "Abyssinian",
                description: "One of the oldest known breeds, curious and energetic.",
                origin: "Egypt",
                intelligence: 5,
                adaptability: 3,
                imageURL: URL(string: "https://cdn2.thecatapi.com/images/aby.jpg"),
                countryCode: "EG",
                flagEmoji: "🇪🇬"
            )
        ]
    }
}
