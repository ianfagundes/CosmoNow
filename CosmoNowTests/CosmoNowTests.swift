//
//  CosmoNowTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 12/02/25.
//

import XCTest
@testable import CosmoNow

final class CosmoNowTests: XCTestCase {
    var service: MockCosmoService!

    override func setUp() {
        super.setUp()
        service = MockCosmoService()
    }

    func testFetchCosmo() async throws {
        do {
            let cosmo = try await service.fetchCosmo(for: "2025-02-12")
            XCTAssertNotNil(cosmo, "Cosmo não deve ser nulo")
            XCTAssertFalse(cosmo.title.isEmpty, "O título não pode ser vazio.")
            XCTAssertFalse(cosmo.url.isEmpty == true, "A URL não pode ser vazia.")

            print("### Teste ok \(cosmo)")
        } catch {
            XCTFail("Erro ao buscar dados: \(error.localizedDescription)")
        }
    }
}
