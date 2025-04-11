//
//  BreedListViewModel.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 4/04/25.
//
import Foundation
import Combine

enum Loadable<T> {
    case idle
    case loading
    case loaded(T)
    case failed(ServiceError)
}

class CatBreedListViewModel: ObservableObject {
    @Published var state: Loadable<[CatBreedModel]> = .idle
    @Published var breeds: [CatBreedModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    @Published var filteredBreeds: [CatBreedModel] = []

    var cancellables: Set<AnyCancellable> = []
    let fetchCatBreedsUseCase: FetchCatBreedsUseCaseProtocol
    
    init(fetchCatBreedsUseCase: FetchCatBreedsUseCaseProtocol) {
        self.fetchCatBreedsUseCase = fetchCatBreedsUseCase
        fetchBreeds()
        setupSearch()
    }
    
    func fetchBreeds() {
        isLoading = true
        state = .loading
        fetchCatBreedsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.state = .failed(error)
                    self?.errorMessage = error.errorDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] breeds in
                self?.breeds = breeds.map(CatBreedMapper.map)
                self?.filteredBreeds = self?.breeds ?? []
                self?.state = .loaded(self?.filteredBreeds ?? [])
            })
            .store(in: &cancellables)
    }


    func setupSearch() {
          $searchText
              .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
              .removeDuplicates()
              .sink { [weak self] text in
                  self?.filterBreeds(with: text)
              }
              .store(in: &cancellables)
      }
    
    func filterBreeds(with text: String) {
        guard case .loaded(let breeds) = state else { return }
        
        if text.isEmpty {
            filteredBreeds = breeds
        } else {
            filteredBreeds = breeds.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
    }
}
