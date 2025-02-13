//
//  MockCosmoService.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

@testable import CosmoNow
import Foundation

class MockCosmoService: CosmoServiceProtocol, @unchecked Sendable {
    var shouldFail = false

    func fetchCosmo(for date: String?) async throws -> CosmoModel {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return CosmoModel(
            date: "2025-02-12",
            explanation: "What can a space rock tell us about life on Earth?  NASA's OSIRIS-REx spacecraft made a careful approach to the near-Earth asteroid 101955 Bennu in October of 2020 to collect surface samples.  In September 2023, the robotic spaceship returned these samples to Earth.  A recent analysis has shown, surprisingly, that the samples contained 14 out of the 20 known amino acids that are the essential building blocks of life.  The presence of the amino acids re-introduces a big question: Could life have originated in space?  However, the protein building blocks themselves held another surprise -- they contained an even mixture of left-handed and right-handed amino acids -- in contrast to our Earth which only has left-handed ones.  This raises another big question: Why does life on Earth have only left-handed amino acids?  Research on this is sure to continue.",
            mediaType: "video",
            serviceVersion: "v1",
            title: "Asteroid Bennu Holds the Building Blocks of Life",
            url: "https://www.youtube.com/embed/ukCSRYcjSQw?rel=0"
        )
    }
}
