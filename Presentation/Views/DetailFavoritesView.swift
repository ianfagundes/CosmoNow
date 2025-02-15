//
//  DetailFavoritesView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation
import SwiftUI

struct DetailFavoritesView: View {
    let cosmo: CosmoModel
    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        VStack {
            Text(cosmo.title)
                .font(.title)
                .foregroundColor(ThemeManager.secondaryColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            CachedAsyncImage(
                url: cosmo.url,
                width: UIScreen.main.bounds.width - 64,
                height: 192
            )
            .cornerRadius(10)
            .padding()

            ScrollView {
                Text(cosmo.explanation)
                    .font(.body)
                    .padding(.horizontal)
            }
            .frame(maxHeight: 200)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)

            FavoriteButton(
                isFavorite: Binding(
                    get: { viewModel.isFavorite(cosmo) },
                    set: { _ in viewModel.toggleFavorite(cosmo) }
                )
            )
        }
    }
}
