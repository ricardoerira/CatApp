//
//  CatBreedRowView.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation
import SwiftUI
struct BreedCardView: View {
    let breed: CatBreed

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(breed.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("Más...")
                    .font(.headline)
                    .foregroundColor(.white)
            }

            // Image
            AsyncImage(url: breed.imageURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .scaledToFit()
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            // Info Row with Flag and Intelligence
            HStack {
                Text("\(flagEmoji(for: breed.countryCode))").font(.largeTitle)
                Text( breed.countryCode).font(.headline)
                Spacer()
                Text("🧠 \(breed.intelligence)/5")
                
            }
            .foregroundColor(.white.opacity(0.8))
            .padding(.horizontal)
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.2))
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 0.5)
                )
        )
        .shadow(color: Color.white.opacity(0.3), radius: 8, x: 0, y: 4)
    }

    // Function to get country flag emoji from country code
    func flagEmoji(for countryCode: String) -> String {
        countryCode.uppercased().unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }
        .map { String($0) }
        .joined()
    }
}
