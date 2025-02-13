//
//  MockCosmoService.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

@testable import CosmoNow
import Foundation

final class MockCosmoService: CosmoServiceProtocol {
    var shouldFail = false

    func fetchCosmo(for date: String?) async throws -> CosmoModel {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return CosmoModel(
            date: "2025-02-12",
            explanation: "What can a space rock tell us about life on Earth?",
            mediaType: "video",
            serviceVersion: "v1",
            title: "Asteroid Bennu Holds the Building Blocks of Life",
            url: "https://www.youtube.com/embed/ukCSRYcjSQw?rel=0"
        )
    }
}
