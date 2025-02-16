//
//  YouTubeUtils.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 15/02/25.
//

import Foundation

struct YouTubeUtils {
    static func extractYouTubeVideoID(from urlString: String) -> String? {
        guard let url = URL(string: urlString), let host = url.host else {
            return nil
        }

        let pathComponents = url.pathComponents
        if pathComponents.contains("embed"),
           let videoIDIndex = pathComponents.firstIndex(of: "embed"),
           videoIDIndex + 1 < pathComponents.count {
            let videoID = pathComponents[videoIDIndex + 1]

            return videoID
        }

        if host.contains("youtu.be") {
            let videoID = url.pathComponents.last

            return videoID
        }

        if host.contains("youtube.com") {
            if let components = URLComponents(string: urlString),
               let queryItems = components.queryItems {
                let videoID = queryItems.first(where: { $0.name == "v" })?.value

                return videoID
            }
        }

        return nil
    }
    
    static func replaceInYoutubeURL(with videoID: String) -> String {
        return "https://img.youtube.com/vi/\(videoID)/hqdefault.jpg"
    }
}
