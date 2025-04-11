//
//  CatBreedDetailView.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//

import SwiftUI

struct CatBreedDetailView: View {
    let breed: CatBreedModel
    let image: Image?
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var animateContent = false
    
    var body: some View {
        ZStack {
            backgroundBlur
            overlayLayer
            content
        }
        .navigationTitle(breed.name)
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animateContent = true
            }
        }
    }
    
    private var backgroundBlur: some View {
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
                
            }
        }
    }
    
    private var overlayLayer: some View {
        Rectangle()
            .fill(Color.white.opacity(0.25))
            .background(
                BlurView(style: colorScheme == .dark ? .systemThinMaterialDark : .systemThinMaterialLight)
            )
            .ignoresSafeArea()
    }
    
    private var content: some View {
        VStack(spacing: 16) {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 8)
                    .frame(height: 320)
                    .padding(.horizontal)
                    .scaleEffect(animateContent ? 1 : 0.95)
                    .opacity(animateContent ? 1 : 0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.75), value: animateContent)
            }
            
            ScrollView {
                infoSection
                    .opacity(animateContent ? 1 : 0)
                    .offset(y: animateContent ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.1), value: animateContent)
            }
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📜 Description")
                .font(.headline)
            Text(breed.description)
                .font(.body)
                .multilineTextAlignment(.leading)
            
            HStack {
                Text(breed.flagEmoji)
                    .font(.largeTitle)
                Text(breed.origin)
                    .font(.headline)
            }
            
            Text("🧠 Intelligence: \(breed.intelligence)")
            Text("❤️ Adaptability: \(breed.adaptability)")
        }
        .padding()
        
        .padding(.horizontal)
    }
}


struct CatBreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetailView(
            breed: CatBreedModel.preview.first!,
            image: Image(systemName: "photo")
        )
        .preferredColorScheme(.dark)
        
        CatBreedDetailView(
            breed:  CatBreedModel.preview.first!,
            image: Image(systemName: "photo.fill")
        )
        .preferredColorScheme(.light)
    }
}
