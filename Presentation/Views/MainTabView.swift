//
//  MainView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @StateObject private var cosmoViewModel = CosmoViewModel(
        getCosmoUseCase: GetCosmoUseCase(
            repository: CosmoRepository(service: CosmoService())
        )
    )

    var body: some View {
        TabView(selection: $selectedTab) {
            CosmoView()
                .environmentObject(cosmoViewModel)
                .environmentObject(favoritesViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .tag(0)

            DatePickerModalView(viewModel: cosmoViewModel, selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "calendar")
                }
                .tag(1)

            FavoritesView()
                .environmentObject(favoritesViewModel)
                .tabItem {
                    Image(systemName: "heart.fill")
                }
                .tag(2)
        }
        .background(ThemeManager.backgroundColor)
        .accentColor(ThemeManager.primaryColor)
    }
}

#Preview {
    MainTabView()
}
