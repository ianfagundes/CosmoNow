//
//  NetworkManager.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let cacheManager: DataCacheManagerProtocol
    private let session: URLSessionProtocol

    init(cacheManager: DataCacheManagerProtocol = DataCacheManager.shared, session: URLSessionProtocol = URLSession.shared) {
        self.cacheManager = cacheManager
        self.session = session
    }

    func fetch<T: Codable>(url: URL, cacheKey: String) async throws -> T {
        if let cachedData = cacheManager.getCachedData(for: cacheKey) {
            print("Dados carregados do cache (\(cacheKey))")
            return try JSONDecoder().decode(T.self, from: cachedData)
        }

        let result: T = try await request(url: url, method: "GET")

        if let encodedData = try? JSONEncoder().encode(result) {
            cacheManager.saveData(encodedData, for: cacheKey)
        }

        return result
    }

    func request<T: Decodable>(url: URL, method: String, body: Data? = nil) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknownError
            }

            guard (200 ... 299).contains(httpResponse.statusCode) else {
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
        } catch let error as NetworkError {
            throw error
        } catch {
            print("Erro desconhecido: \(error)")
            throw NetworkError.unknownError
        }
    }
}
