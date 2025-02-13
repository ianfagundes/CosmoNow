//
//  MediaManager.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation

final class MediaManager {
    
    static func getMediaType(from rawValue: String) -> MediaType {
        return MediaType(rawValue: rawValue) ?? .unknown
    }
    
    static func getFormattedURL(from urlString: String) -> URL? {
        guard let url = URL(string: urlString), urlString.hasPrefix("https") else { return nil }
        return url
    }
}
