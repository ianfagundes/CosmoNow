//
//  CosmoService.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

class CosmoService {
    private let baseURL: URL = URL(string: "https://api.nasa.gov/planetary/apod")!
    private let apikey: String = "c0cfC2fB8BG5hFkAu8x3bHkw2oUzE8xha4RDpfWC"

    func fetchCosmo(for date: String? = nil) async throws -> CosmoModel {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apikey),
        ]

        if let date = date {
            urlComponents.queryItems?.append(URLQueryItem(name: "date", value: date))
        }

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(CosmoModel.self, from: data)
    }
}
