//
//  CosmoDetailView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 15/02/25.
//

import Foundation
import SwiftUI

struct CosmoDetailView: View {
    let cosmo: CosmoModel
    @ObservedObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 5) {
                    Text(cosmo.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(ThemeManager.secondaryColor)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 32)

                    Text(DateUtils.formatDate(cosmo.date))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                ZStack(alignment: .bottomTrailing) {
                    if let url = URL(string: cosmo.url) {
                        MediaView(mediaType: cosmo.mediaType, mediaURL: url)
                            .frame(width: UIScreen.main.bounds.width - 64, height: 192)
                            .cornerRadius(10)
                            .shadow(radius: 4)
                    }

                    FavoriteButton(
                        isFavorite: Binding(
                            get: { favoritesViewModel.isFavorite(cosmo) },
                            set: { _ in favoritesViewModel.toggleFavorite(cosmo) }
                        )
                    )
                    .padding(12)
                }

                Text(cosmo.explanation)
                    .font(.body)
                    .foregroundColor(ThemeManager.textColor)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 48)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
