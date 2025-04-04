//
//  BreedListViewModel.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//
import Foundation
import Combine

final class BreedListViewModel: ObservableObject {
    @Published var breeds: [CatBreed] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    @Published var filteredBreeds: [CatBreed] = []

    var cancellables: Set<AnyCancellable> = []
    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        fetchBreeds()
        setupSearch()
    }

    
    func fetchBreeds() {
        service.fetch([CatBreed].self, from:  "/breeds")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching breeds: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] breeds in
                self?.breeds = breeds
                self?.filteredBreeds = breeds
            })
            .store(in: &cancellables) // ✅ Must be of type Set<AnyCancellable>
    }
    
    private func setupSearch() {
          $searchText
              .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main) // Avoids rapid API calls
              .removeDuplicates()
              .sink { [weak self] text in
                  self?.filterBreeds(with: text)
              }
              .store(in: &cancellables)
      }
    
    private func filterBreeds(with text: String) {
           if text.isEmpty {
               filteredBreeds = breeds
           } else {
               filteredBreeds = breeds.filter { $0.name.localizedCaseInsensitiveContains(text) }
           }
       }
}
