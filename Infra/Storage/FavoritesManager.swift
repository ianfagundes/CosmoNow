//
//  LocalStorage.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

protocol FavoritesManaging {
    func getFavorites() -> [CosmoModel]
    func saveFavorite(_ item: CosmoModel)
    func removeFavorite(_ item: CosmoModel)
    func removeFavorites(_ ids: [String])
}

final class FavoritesManager: FavoritesManaging {
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favoriteCosmos"
    private let defaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
    }
    
    func saveFavorite(_ cosmo: CosmoModel) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.date == cosmo.date }) {
            favorites.append(cosmo)
            save(favorites)
        }
    }

    func removeFavorite(_ cosmo: CosmoModel) {
        var favorites = getFavorites()
        favorites.removeAll { $0.date == cosmo.date }
        save(favorites)
    }

    func isFavorite(_ cosmo: CosmoModel) -> Bool {
        getFavorites().contains { $0.date == cosmo.date }
    }

    func getFavorites() -> [CosmoModel] {
        guard let data = defaults.data(forKey: favoritesKey),
              let decoded = try? JSONDecoder().decode([CosmoModel].self, from: data) else {
            return []
        }
        return decoded
    }

    func removeFavorites(_ ids: [String]) {
        var favorites = getFavorites()
        favorites.removeAll { ids.contains($0.id) }
        save(favorites)
    }
    
    private func save(_ favorites: [CosmoModel]) {
        if let encoded = try? JSONEncoder().encode(favorites) {
            defaults.set(encoded, forKey: favoritesKey)
        }
    }
}
