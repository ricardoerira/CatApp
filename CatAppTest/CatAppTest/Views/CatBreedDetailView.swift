//
//  CatBreedDetailView.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation
import SwiftUI

struct CatBreedDetailView: View {
    let breed: CatBreed

    var body: some View {
        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                if let url = breed.image?.url, let imageURL = URL(string: url) {
//                    AsyncImage(url: imageURL) { image in
//                        image.resizable()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(height: 200)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                }
//
//                Text(breed.name)
//                    .font(.largeTitle)
//                    .bold()
//
//                if let description = breed.description {
//                    Text(description)
//                }
//
//                if let origin = breed.origin {
//                    Text("Origin: \(origin)")
//                }
//
//                if let lifeSpan = breed.life_span {
//                    Text("Life span: \(lifeSpan) years")
//                }
//
//                if let temperament = breed.temperament {
//                    Text("Temperament: \(temperament)")
//                }
//            }
//            .padding()
        }
        .navigationTitle(breed.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
