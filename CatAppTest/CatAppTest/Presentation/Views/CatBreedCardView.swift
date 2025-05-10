//
//  CatBreedRowView.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import Foundation
import SwiftUI

struct CatBreedCardView: View {
    let breed: CatBreedModel
    @State private var isImageLoaded = false
    @State var downloadedImage: Image?
    
    var body: some View {
        VStack(alignment: .leading) {
            titleRow
            imageSection
            infoRow
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

    private var titleRow: some View {
        HStack {
            Text(breed.name)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            NavigationLink(destination: CatBreedDetailView(breed: breed, image: downloadedImage)) {
                Text(NSLocalizedString("more_button", comment: ""))
                    .font(.headline)
                    .padding(8)
                    .foregroundColor(.white)
            }
        }
    }
    
    private var imageSection: some View {
        AsyncImage(url: breed.imageURL) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
                    .onAppear {
                        downloadedImage = image
                        withAnimation { isImageLoaded = true }
                        
                    }
                
                
            case .failure:
                fallbackImage

            default:
                ProgressView().progressViewStyle(.circular).foregroundColor(.white)
            }
        }
        .scaledToFit()
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var fallbackImage: some View {
          ZStack {
              Color.gray.opacity(0.2)
              Image(systemName: "photo")
                  .resizable()
                  .scaledToFit()
                  .frame(height: 150)
                  .foregroundColor(.white.opacity(0.5))
          }
          .clipShape(RoundedRectangle(cornerRadius: 12))
      }
    
    private var infoRow: some View {
        HStack {
            Text(breed.flagEmoji).font(.largeTitle)
            Text( breed.countryCode).font(.headline)
            Spacer()
            Text("🧠 \(breed.intelligence)/5")
            
        }
        .foregroundColor(.white.opacity(0.8))
        .padding(.horizontal)
    }
}
