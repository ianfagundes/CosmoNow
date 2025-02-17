//
//  ContentView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var favoritesViewModel: FavoritesViewModel
    @StateObject private var cosmoViewModel: CosmoViewModel

    init(
        favoritesViewModel: FavoritesViewModel? = nil,
        cosmoViewModel: CosmoViewModel? = nil
    ) {
        _favoritesViewModel = StateObject(wrappedValue: favoritesViewModel ?? FavoritesViewModel(favoritesManager: FavoritesManager.shared))
        
        _cosmoViewModel = StateObject(wrappedValue: cosmoViewModel ?? {
            Task { @MainActor in
                return CosmoViewModel(getCosmoUseCase: GetCosmoUseCase(repository: CosmoRepository(service: CosmoService())))
            }
            return CosmoViewModel(getCosmoUseCase: GetCosmoUseCase(repository: CosmoRepository(service: CosmoService()))) 
        }())
    }

    var body: some View {
        MainTabView()
            .environmentObject(favoritesViewModel)
            .environmentObject(cosmoViewModel)
    }
}
