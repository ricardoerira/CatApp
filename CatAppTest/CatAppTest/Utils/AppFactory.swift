//
//  Factory.swift
//  CatAppTest
//
//  Created by Wilson Ricardo Erira  on 8/04/25.
//

import Foundation


final class AppFactory {
    static let shared = AppFactory()

    private init() {}
    
    func makeBreedListViewModel() -> CatBreedListViewModel {
        let remoteService = APIService()
        let offlineService = OfflineService(persistentContainer: PersistenceController.shared.container)
        let repository = CatBreedRepository(remoteService: remoteService,
                                            offlineService: offlineService)
        
        let useCase = FetchCatBreedsUseCase(repository: repository)
        return CatBreedListViewModel(fetchCatBreedsUseCase: useCase)
    }
}

