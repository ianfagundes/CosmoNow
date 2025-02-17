//
//  ImageCacheManager.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0].appendingPathComponent("ImageCache")

        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    func getImage(for url: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSString) {
            return cachedImage
        } else if let diskImage = loadImageFromDisk(for: url) {
            cache.setObject(diskImage, forKey: url as NSString)
            return diskImage
        }
        return nil
    }
    
    func saveImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
        saveImageToDisk(image, for: url)
    }
    
    private func saveImageToDisk(_ image: UIImage, for url: String) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let fileURL = cacheDirectory.appendingPathComponent(url.hashValue.description)
        try? data.write(to: fileURL)
    }

    private func loadImageFromDisk(for url: String) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(url.hashValue.description)
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        return nil
    }
}
