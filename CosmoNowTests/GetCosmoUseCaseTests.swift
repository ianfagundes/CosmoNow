//
//  GetCosmoUseCaseTests.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

@testable import CosmoNow
import XCTest

final class GetCosmoUseCaseTests: XCTestCase {
    var mockService: MockCosmoService!
    var useCase: GetCosmoUseCase!

    override func setUp() {
        super.setUp()
        mockService = MockCosmoService()
        useCase = GetCosmoUseCase(repository: mockService)
    }

    func testExecute_Success() async {
        do {
            let cosmo = try await useCase.execute(for: nil)
            XCTAssertEqual(cosmo.title, "Asteroid Bennu Holds the Building Blocks of Life")
            XCTAssertEqual(cosmo.url, "https://www.youtube.com/embed/ukCSRYcjSQw?rel=0")
        } catch {
            XCTFail("Erro inesperado ao buscar o Cosmo")
        }
    }

    func testExecute_Failure() async {
        mockService.shouldFail = true

        do {
            _ = try await useCase.execute(for: nil)
            XCTFail("A requisição deveria ter falhado, mas não falhou")
        } catch {
            XCTAssertNotNil(error, "Erro esperado, mas nenhum erro foi lançado.")
        }
    }
}
