//
//  FavoriteManager.swift
//  CatAppTest
//
//  Created by andres on 4/04/25.
//

import Foundation
import Combine

class FavoriteManager: ObservableObject {
    static let shared = FavoriteManager()
    
    @Published private(set) var favoriteIDs: Set<String> = []
    private let defaults = UserDefaults.standard
    private let key = UserDefaultsKeys.favoritesKey

    private init() {
        loadFavorites()
    }

    func toggleFavorite(id: String) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }
        saveFavorites()
    }

    func isFavorite(id: String) -> Bool {
        return favoriteIDs.contains(id)
    }

    private func saveFavorites() {
        let ids = Array(favoriteIDs)
        defaults.set(ids, forKey: key)
    }

    private func loadFavorites() {
        if let saved = defaults.array(forKey: key) as? [String] {
            favoriteIDs = Set(saved)
        }
    }
}
