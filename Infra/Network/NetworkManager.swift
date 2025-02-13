//
//  NetworkManager.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}
    
    func fetch<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknownError
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badStatusCode(httpResponse.statusCode)
            }

            guard !data.isEmpty else {
                throw NetworkError.noData
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }

        } catch let error as URLError {
            throw NetworkError.requestFailed(error)
        } catch {
            throw NetworkError.unknownError
        }
    }
}
