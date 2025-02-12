//
//  CosmoNowTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 12/02/25.
//

@testable import CosmoNow
import XCTest

final class CosmoNowTests: XCTestCase {
    var service: CosmoService!

    override func setUp() {
        super.setUp()
        service = CosmoService()
    }

    func testFetchCosmo() async throws {
        do {
            let cosmo = try await service.fetchCosmo()
            XCTAssertNotNil(cosmo, "Cosmo não deve ser nulo")
            XCTAssertFalse(cosmo.title.isEmpty, "O título não ser vazio.")
            XCTAssertFalse(cosmo.url.isEmpty, "A URL não pode ser vazia.")

            print("### teste ok \(cosmo)")
        } catch {
            XCTFail("Erro ao buscar dados: \(error.localizedDescription)")
        }
    }
}
