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
        ProgressView("Loading breeds...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
            .foregroundColor(.white)
    }

    private func errorView(error: Error) -> some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Oops!")
                .font(.largeTitle.bold())
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
    }

    private func loadedBreedsView(filteredBreeds: [CatBreedModel]) -> some View {
        VStack(spacing: 16) {
            Text("CatApp")
                .foregroundColor(.white.opacity(0.8))

            TextField("Search breeds...", text: $viewModel.searchText)
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



struct CatBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CatBreedListView(viewModel: MockCatBreedListViewModel.loading)
                .previewDisplayName("Loading State")
                .preferredColorScheme(.dark)

            CatBreedListView(viewModel: MockCatBreedListViewModel.loaded)
                .previewDisplayName("Loaded State")
                .preferredColorScheme(.light)

            CatBreedListView(viewModel: MockCatBreedListViewModel.error)
                .previewDisplayName("Error State")
                .preferredColorScheme(.dark)
        }
    }
}
