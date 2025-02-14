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

        var urlComponents = URLComponents(url: .nasaCosmoURL, resolvingAgainstBaseURL: true)!

        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: APIConfig.apiKey),
            URLQueryItem(name: "date", value: selectedDate),
        ]

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        return try await NetworkManager.shared.fetch(url: url, cacheKey: cacheKey)
    }
}
