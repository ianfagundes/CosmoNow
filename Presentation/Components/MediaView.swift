//
//  MediaView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import AVKit
import SwiftUI

struct MediaView: View {
    let mediaType: MediaType
    let mediaURL: URL?

    var body: some View {
        if let url = mediaURL {
            switch mediaType {
            case .image:
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            case .video:
                if isYouTubeURL(url) {
                    YouTubeWebView(videoURL: url)
                        .frame(height: 300)
                } else {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 300)
                }
            case .unknown:
                Text("Mídia não suportada")
                    .foregroundColor(.gray)
            }
        } else {
            Text("Mídia não disponivel")
                .foregroundColor(.gray)
        }
    }
}

extension MediaView {
    private func isYouTubeURL(_ url: URL) -> Bool {
        return url.absoluteString.contains("youtube.com") || url.absoluteString.contains("youtu.be")
    }
}
