//
//  CatBreed.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation


struct CatBreed: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var description: String?
    var temperament: String?
    var origin: String?
    var life_span: String?
    var image: CatImage?

    struct CatImage: Codable, Equatable {
        var url: String?
    }
}
