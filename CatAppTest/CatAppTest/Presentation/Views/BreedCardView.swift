//
//  CatBreedRowView.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation
import SwiftUI

struct BreedCardView: View {
    let breed: CatBreedModel
    @State var downloadedImage: Image?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(breed.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
 
                NavigationLink(destination: CatBreedDetailView(breed: breed, image: downloadedImage)) {
                    Text("Más...")
                        .font(.headline)
                        .padding(8)
                        .foregroundColor(.white)
                }
            }

            AsyncImage(url: breed.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .clipped()
                        .onAppear { downloadedImage = image } 
                    
                case .failure:
                    ProgressView().progressViewStyle(.circular).foregroundColor(.white)

                default:
                    ProgressView().progressViewStyle(.circular).foregroundColor(.white)
                }
            }

            .scaledToFit()
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            // Info Row with Flag and Intelligence
            HStack {
                Text(breed.flagEmoji).font(.largeTitle)
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
   
}
