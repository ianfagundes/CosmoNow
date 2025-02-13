//
//  CosmoViewModelTests.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

@testable import CosmoNow
import XCTest

final class CosmoViewModelTests: XCTestCase {
    var mockRepository: MockCosmoRepository!
    var useCase: GetCosmoUseCase!
    var viewModel: CosmoViewModel!

    override func setUp() {
        super.setUp()
        mockRepository = MockCosmoRepository()
        useCase = GetCosmoUseCase(repository: mockRepository)
        viewModel = CosmoViewModel(getCosmoUseCase: useCase)
    }

    func testFetchCosmo_Success() async {
        XCTAssertNil(viewModel.cosmo)
        XCTAssertFalse(viewModel.isLoading)

        await viewModel.fetchCosmo()

        XCTAssertNotNil(viewModel.cosmo, "Cosmo deve estar preenchido após a busca.")
        XCTAssertEqual(viewModel.cosmo?.title, "Asteroid Bennu Holds the Building Blocks of Life")
        XCTAssertEqual(viewModel.cosmo?.url, "https://www.youtube.com/embed/ukCSRYcjSQw?rel=0")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testFetchCosmo_Failure() async {
        mockRepository.shouldFail = true

        await viewModel.fetchCosmo()

        XCTAssertNil(viewModel.cosmo, "Cosmo deve ser nil em caso de erro.")
        XCTAssertNotNil(viewModel.errorMessage, "Deve haver uma mensagem de erro.")
        XCTAssertFalse(viewModel.isLoading)
    }
}
