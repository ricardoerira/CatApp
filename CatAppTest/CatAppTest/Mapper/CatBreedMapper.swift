//
//  CatBreedMapper.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 7/04/25.
//

import Foundation

struct CatBreedMapper {
    static func map(_ model: CatBreed) -> CatBreedModel {
        return CatBreedModel(
            id: model.id,
            name: model.name,
            description: model.description,
            origin: model.origin,
            intelligence: model.intelligence,
            adaptability: model.adaptability,
            imageURL: model.imageURL,
            countryCode: model.countryCode,
            flagEmoji: Helper.flagEmoji(for: model.countryCode)
        )
    }
}
