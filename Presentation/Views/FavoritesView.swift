//
//  FavoritesView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var viewModel: FavoritesViewModel
    @State private var isEditing = false
    @State private var selectedFavorites: Set<String> = []

    var body: some View {
        NavigationView {
            List(viewModel.favorites, id: \.id) { cosmo in
                HStack {
                    if isEditing {
                        Image(systemName: selectedFavorites.contains(cosmo.id) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(selectedFavorites.contains(cosmo.id) ? .red : .gray)
                            .onTapGesture {
                                if selectedFavorites.contains(cosmo.id) {
                                    selectedFavorites.remove(cosmo.id)
                                } else {
                                    selectedFavorites.insert(cosmo.id)
                                }
                            }
                    }

                    NavigationLink(destination: DetailFavoritesView(cosmo: cosmo, viewModel: viewModel)) {
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
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Confirm" : "Edit") {
                        if isEditing {
                            if !selectedFavorites.isEmpty {
                                viewModel.removeFavorites(Array(selectedFavorites))
                                selectedFavorites.removeAll()
                            }
                        }
                        isEditing.toggle()
                    }
                    .padding(.trailing, 8)
                }
            }
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}
