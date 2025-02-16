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
                CachedAsyncImage(url: url.absoluteString, width: UIScreen.main.bounds.width - 64, height: 192)

            case .video:
                if isYouTubeURL(url) {
                    CachedAsyncImage(
                        url: YouTubeUtils.replaceInYoutubeURL(with: YouTubeUtils.extractYouTubeVideoID(from: url.absoluteString) ?? ""),
                        width: UIScreen.main.bounds.width - 64,
                        height: 192
                    )
                    .overlay(
                        YouTubeWebView(videoURL: url)
                            .frame(width: UIScreen.main.bounds.width - 64, height: 192)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
                } else if url.isFileURL || url.absoluteString.hasSuffix(".mp4") {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 192)
                } else {
                    Text("Formato de vídeo não suportado")
                        .foregroundColor(.red)
                }

            case .unknown:
                Text("Mídia não suportada")
                    .foregroundColor(.gray)
            }
        } else {
            Text("Mídia não disponível")
                .foregroundColor(.gray)
        }
    }
}

extension MediaView {
    private func isYouTubeURL(_ url: URL) -> Bool {
        return url.absoluteString.contains("youtube.com") || url.absoluteString.contains("youtu.be")
    }
}
