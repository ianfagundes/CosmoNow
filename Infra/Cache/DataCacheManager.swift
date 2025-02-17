//
//  DataCacheManager.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation

protocol DataCacheManagerProtocol {
    func getCachedData(for key: String) -> Data?
    func saveData(_ data: Data, for key: String)
}

final class DataCacheManager: DataCacheManagerProtocol {
    static let shared = DataCacheManager()
    private let cache = URLCache.shared
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = paths[0].appendingPathComponent("DataCache")
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }

    func getCachedData(for key: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(key.hashValue.description)

        if let requestURL = URL(string: key), let cachedResponse = cache.cachedResponse(for: URLRequest(url: requestURL)) {
            return cachedResponse.data
        } else if let data = try? Data(contentsOf: fileURL) {
            return data
        }
        return nil
    }

    func saveData(_ data: Data, for key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key.hashValue.description)

        if let requestURL = URL(string: key) {
            let response = CachedURLResponse(response: URLResponse(), data: data)
            cache.storeCachedResponse(response, for: URLRequest(url: requestURL))
        }

        try? data.write(to: fileURL)
    }
}
