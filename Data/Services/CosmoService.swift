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
        let url: URL = .nasaCosmoURL
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: APIConfig.apiKey),
            //FIXME: - Remover data "chumbada
            URLQueryItem(name: "date", value: "2024-02-12"),
        ]

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        print("URL gerada: \(url.absoluteString)")

        return try await NetworkManager.shared.fetch(url: url)
    }
}
