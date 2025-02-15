//
//  CosmoView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

//
//  CosmoView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation
import SwiftUI

struct CosmoView: View {
    @EnvironmentObject var viewModel: CosmoViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.isLoading && viewModel.cosmo == nil {
                ProgressView()
                    .scaleEffect(1.5)
            } else if let cosmo = viewModel.cosmo {
                VStack(spacing: 5) {
                    Text(cosmo.title)
                        .font(.title)
                        .foregroundColor(ThemeManager.secondaryColor).multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 32)

                    Text(cosmo.date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                ZStack(alignment: .bottomTrailing) {
                    if cosmo.mediaType == .image {
                        CachedAsyncImage(
                            url: cosmo.mediaURL?.absoluteString ?? "",
                            width: UIScreen.main.bounds.width - 64,
                            height: 192
                        )
                        .cornerRadius(10)
                        .padding(.top, 5)
                    } else {
                        MediaView(mediaType: cosmo.mediaType, mediaURL: cosmo.mediaURL)
                            .frame(width: UIScreen.main.bounds.width - 64, height: 192)
                            .cornerRadius(10)
                            .padding(.top, 5)
                    }

                    FavoriteButton(
                        isFavorite: Binding(
                            get: { favoritesViewModel.isFavorite(CosmoModel(from: cosmo)) },
                            set: { _ in favoritesViewModel.toggleFavorite(CosmoModel(from: cosmo)) }
                        )
                    )
                }
                ScrollView {
                    Text(cosmo.explanation)
                        .font(.body)
                        .foregroundColor(ThemeManager.textColor)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 48)
                }
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()

                    Button("Tentar Novamente") {
                        Task {
                            await viewModel.fetchCosmo()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
        }
        .onAppear {
            Task {
                if viewModel.cosmo == nil {
                    await viewModel.fetchCosmo()
                }
            }
        }
    }
}
