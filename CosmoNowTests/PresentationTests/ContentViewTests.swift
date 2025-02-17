//
//  File.swift
//  CosmoNowUITests
//
//  Created by Ian Fagundes on 17/02/25.
//

import XCTest
import SwiftUI
@testable import CosmoNow

final class ContentViewTests: XCTestCase {
    
    @MainActor func testContentViewWithMockedViewModels() {
        let favoritesMock = FavoritesViewModel(favoritesManager: FavoritesManagerMock())
        let cosmoMock = CosmoViewModel(getCosmoUseCase: GetCosmoUseCase(repository: CosmoRepository(service: CosmoService())))

        let view = ContentView(favoritesViewModel: favoritesMock, cosmoViewModel: cosmoMock)
        let host = UIHostingController(rootView: view)

        XCTAssertNotNil(host.view, "A ContentView não deveria ser nula.")
    }
}
