//
//  FavoritesView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    @State private var favorites: [CosmoModel] = FavoritesManager.shared.getFavorites()

    var body: some View {
        NavigationView {
            List(favorites, id: \.date) { cosmo in
                NavigationLink(destination: DetailFavoritesView(cosmo: cosmo)) {
                    HStack(spacing: 16) {
                        CachedAsyncImage(url: cosmo.url, width: 60, height: 60)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .background(Color.clear)
                            .clipped()

                        VStack(alignment: .leading) {
                            Text(cosmo.title)
                                .font(.subheadline)
                                .foregroundColor(ThemeManager.primaryColor)
                            Text(cosmo.date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Favorites")
                        .font(.headline)
                        .foregroundColor(ThemeManager.primaryColor)
                }
            }
        }
        .onAppear {
            favorites = FavoritesManager.shared.getFavorites()
        }
    }
}
