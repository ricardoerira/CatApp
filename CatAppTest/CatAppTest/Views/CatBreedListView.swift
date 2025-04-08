//
//  CatBreedListView.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import SwiftUI

struct CatBreedListView: View {
    @State private var searchText = ""
    @StateObject private var viewModel: CatBreedListViewModel
    
    init(viewModel: CatBreedListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Loading breeds...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.white)
                case .failed(let error):
                    
                    HStack(spacing: 20) {
                        Spacer()
                        VStack(spacing: 20) {
                            Spacer()

                            Text("Oops!")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("Something went wrong:\n\(error.localizedDescription)")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.horizontal)

                            Button(action: {
                                viewModel.fetchBreeds()
                            }) {
                                Text("Retry")
                                    .fontWeight(.semibold)
                                    .padding()
                                    .frame(maxWidth: 120)
                                    .background(Color.white)
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }

                            Spacer()
                        }
                        .padding()
                        Spacer()
                    }
                    
                case .loaded:
                    HStack {
                        Spacer()
                        Text("CatApp")
                            .foregroundColor(.white).opacity(0.8)
                            .accessibilityIdentifier("AppTitle")
                        
                        Spacer()
                    }
                    
                    TextField("Search breeds...", text: $viewModel.searchText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .accessibilityIdentifier("SearchField")
                    
                    
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.filteredBreeds) { breed in
                                BreedCardView(breed: breed)
                                    .accessibilityIdentifier("BreedCard_\(breed.id)")
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("")
            .background(LinearGradient(
                gradient: Gradient(colors: [Color.purple, Color.black]),
                startPoint: .top,
                endPoint: .bottom
            ).edgesIgnoringSafeArea(.all))
        }
    }
}
