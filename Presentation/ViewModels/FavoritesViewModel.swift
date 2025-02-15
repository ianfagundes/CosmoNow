//
//  FavoritesViewModel.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 14/02/25.
//

import Combine
import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [CosmoModel] = []
    private var favoriteIds: Set<String> = []
    let favoritesManager = FavoritesManager.shared

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        let storedFavorites = favoritesManager.getFavorites()
        favorites = storedFavorites
        favoriteIds = Set(storedFavorites.map { $0.id })
    }

    func toggleFavorite(_ item: CosmoModel) {
        if favoriteIds.contains(item.id) {
            removeFavorite(item)
        } else {
            addFavorite(item)
        }
    }

    func addFavorite(_ item: CosmoModel) {
        guard !favoriteIds.contains(item.id) else { return }
        favorites.append(item)
        favoriteIds.insert(item.id)
        favoritesManager.saveFavorite(item)
    }

    func removeFavorite(_ item: CosmoModel) {
        guard favoriteIds.contains(item.id) else { return }
        favorites.removeAll { $0.id == item.id }
        favoriteIds.remove(item.id)
        favoritesManager.removeFavorite(item)
    }

    func removeFavorites(_ ids: [String]) {
        let idSet = Set(ids)
        favorites.removeAll { idSet.contains($0.id) }
        favoriteIds.subtract(idSet)
        favoritesManager.removeFavorites(ids)
    }

    func isFavorite(_ item: CosmoModel) -> Bool {
        return favoriteIds.contains(item.id)
    }
}
