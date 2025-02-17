//
//  CachedAsyncImage.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: String
    let width: CGFloat
    let height: CGFloat

    @StateObject private var viewModel = CachedImageViewModel()

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(12)
                    .transition(.opacity)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .transition(.opacity)
            }

            if viewModel.isLoading {
                Color.black.opacity(0.1)
                    .frame(width: width, height: height)
                    .cornerRadius(12)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .tint(ThemeManager.ProgressIndicator)
                            .scaleEffect(1.2)
                    )
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.image)
        .onAppear {
            viewModel.loadImage(from: url)
        }
        .onChange(of: url) { newUrl in
            viewModel.loadImage(from: newUrl)
        }
    }
}
