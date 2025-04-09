//
//  CatBreedDetailView.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import SwiftUI

struct CatBreedDetailView: View {
    let breed: CatBreedModel
    let image: Image?

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .ignoresSafeArea()
                    .blur(radius: 10)
           
            }
            Rectangle()
                .fill(Color.white.opacity(0.2))
            BlurView(style: colorScheme == .dark ? .systemThinMaterialDark : .systemThinMaterialLight)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                        .frame(height: 350)
                        .padding()
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("📜 Description:")
                            .font(.headline)
                        Text(breed.description)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        HStack {
                            Text(breed.flagEmoji).font(.largeTitle)
                            Text(breed.origin)
                        }
                        
                        Text("⭐ Intelligence: \(breed.intelligence)")
                        Text("❤️ Adaptability: \(breed.adaptability)")
                       
                    }
                    
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(breed.name)
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}
