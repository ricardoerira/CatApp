//
//  CatBreedListView.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//
import SwiftUI

struct CatBreedListView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel: CatBreedListViewModel

    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .idle, .loading:
                    loadingView

                case .failed(let error):
                    errorView(error: error)
               
                case .loaded(let breeds):
                    loadedBreedsView(filteredBreeds: breeds)
                }
            }
            .navigationTitle("")
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

extension CatBreedListView {
    
    private var loadingView: some View {
        ProgressView(NSLocalizedString("loading_breeds", comment: ""))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
            .foregroundColor(.white)
    }

    private func errorView(error: ServiceError) -> some View {
        VStack(spacing: 20) {
            Spacer()
            Text(NSLocalizedString("oops", comment: ""))
                .font(.largeTitle.bold())
                .foregroundColor(.white)

            Text(error.errorDescription ?? "")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.headline)
                .padding(.horizontal)

            Button(action: {
                viewModel.fetchBreeds()
            }) {
                Text(NSLocalizedString("retry", comment: ""))
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }

    private func loadedBreedsView(filteredBreeds: [CatBreedModel]) -> some View {
        VStack(spacing: 16) {
            Text("CatApp")
                .foregroundColor(.white.opacity(0.8))

            TextField(NSLocalizedString("search_placeholder", comment: "Search field placeholder"), text: $viewModel.searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .accessibilityIdentifier("SearchField")

            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(filteredBreeds) { breed in
                        CatBreedCardView(breed: breed)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
