//
//  MockCosmoRepository.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

@testable import CosmoNow
import Foundation

final class MockCosmoRepository: CosmoRepositoryProtocol {
    var shouldFail = false

    func fetchCosmo(for date: String?) async throws -> CosmoModel {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return CosmoModel(
            date: "2025-02-12",
            explanation: "Amostra de descrição.",
            mediaType: .video,
            serviceVersion: "v1",
            title: "Asteroid Bennu Holds the Building Blocks of Life",
            url: "https://www.youtube.com/embed/ukCSRYcjSQw?rel=0"
        )
    }
}
