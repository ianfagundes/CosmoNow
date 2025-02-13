//
//  CosmoService.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

class CosmoService: CosmoServiceProtocol {
    func fetchCosmo(for date: String? = nil) async throws -> CosmoModel {
        let selectedDate = date ?? DateUtils.getCurrentDate()
        let cacheKey = "cosmo_\(selectedDate)"

        if let cachedData = DataCacheManager.shared.getCachedData(for: cacheKey) {
            print("Dados carregados do cache (\(cacheKey))")
            return try JSONDecoder().decode(CosmoModel.self, from: cachedData)
        }

        var urlComponents = URLComponents(url: .nasaCosmoURL, resolvingAgainstBaseURL: true)!

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: APIConfig.apiKey),
            URLQueryItem(name: "date", value: selectedDate),
        ]

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        print("URL gerada: \(url.absoluteString)")

        if let cachedData = DataCacheManager.shared.getCachedData(for: url.absoluteString) {
            print("Recuperando dados do cache para a data: \(selectedDate)")
            return try JSONDecoder().decode(CosmoModel.self, from: cachedData)
        }
        
        let result: CosmoModel = try await NetworkManager.shared.fetch(url: url, cacheKey: cacheKey)

        if let encodedData = try? JSONEncoder().encode(result) {
            DataCacheManager.shared.saveData(encodedData, for: cacheKey)
        }

        return result
    }
}
