//
//  ThumbnailView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 15/02/25.
//

import SwiftUI

struct ThumbnailView: View {
    let url: String
    @StateObject private var viewModel = CachedImageViewModel()

    var body: some View {
        Group {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onAppear {
            let cleanedURL = url.trimmingCharacters(in: .whitespacesAndNewlines)
            if let videoID = YouTubeUtils.extractYouTubeVideoID(from: cleanedURL) {
                viewModel.loadImage(from: YouTubeUtils.replaceInYoutubeURL(with: videoID))
            } else {
                viewModel.loadImage(from: url)
            }
        }
    }
}
