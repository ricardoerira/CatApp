//
//  CatBreed.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import Foundation

import Foundation

struct CatBreed: Codable, Identifiable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let countryCode: String
    let description: String
    let intelligence: Int
    let adaptability: Int
    let referenceImageId: String?
    
    var imageURL: URL? {
          guard let referenceImageId = referenceImageId else { return nil }
          return URL(string: "https://cdn2.thecatapi.com/images/\(referenceImageId).jpg")
      }
    
    init(
        id: String,
        name: String,
        temperament: String,
        origin: String,
        countryCode: String,
        description: String,
        intelligence: Int,
        adaptability: Int,
        referenceImageId: String?
    ) {
        self.id = id
        self.name = name
        self.temperament = temperament
        self.origin = origin
        self.countryCode = countryCode
        self.description = description
        self.intelligence = intelligence
        self.adaptability = adaptability
        self.referenceImageId = referenceImageId
    }

    
    init(from entity: CatBreedEntity) {
        self.id = entity.id ?? UUID().uuidString
        self.name = entity.name ?? ""
        self.temperament = entity.temperament  ?? ""
        self.origin = entity.origin  ?? ""
        self.countryCode = entity.countryCode ?? ""
        self.description = entity.breedDescription ?? ""
        self.intelligence = Int(entity.intelligence)
        self.referenceImageId = entity.referenceImageId
        self.adaptability = Int(entity.adaptability)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, temperament, origin,name, description, intelligence,adaptability
        case countryCode = "country_code"
        case referenceImageId = "reference_image_id"
    }
}

struct CatBreedResponse: Codable {
    let catBreed: [CatBreed]
}

struct CatBreedModel: Identifiable {
    let id: String
    let name: String
    let description: String
    let origin: String
    let intelligence: Int
    let adaptability: Int
    let imageURL: URL?
    let countryCode: String
    let flagEmoji: String
}

