//
//  CatBreedListView.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import SwiftUI

struct CatBreedListView: View {
    @ObservedObject var viewModel = BreedListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search breeds...", text: $viewModel.searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // List of Cat Breeds
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(viewModel.filteredBreeds) { breed in
                            BreedCardView(breed: breed)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Catbreeds")
            .background(LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.black]),
                startPoint: .top,
                endPoint: .bottom
            ).edgesIgnoringSafeArea(.all))
        }
    }
}
