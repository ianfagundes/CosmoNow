//
//  FavoritesViewModelTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 17/02/25.
//

import XCTest
import Combine
@testable import CosmoNow

class FavoritesViewModelTests: XCTestCase {
    var viewModel: FavoritesViewModel!
    var favoritesManagerMock: FavoritesManagerMock!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        favoritesManagerMock = FavoritesManagerMock()
        viewModel = FavoritesViewModel(favoritesManager: favoritesManagerMock)
    }

    override func tearDown() {
        viewModel = nil
        favoritesManagerMock = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testLoadFavorites() {
        let expectedFavorites = [
            CosmoModel(date: "2025-02-12", explanation: "Favorite 1", mediaType: .image, serviceVersion: "V1", title: "Title 1", url: "https://example.com/1"),
            CosmoModel(date: "2025-02-13", explanation: "Favorite 2", mediaType: .video, serviceVersion: "V1", title: "Title 2", url: "https://example.com/2")
        ]
        favoritesManagerMock.favorites = expectedFavorites

        viewModel.loadFavorites()

        XCTAssertEqual(viewModel.favorites, expectedFavorites)
    }

    func testAddFavorite() {
        let item = CosmoModel(date: "2025-02-14", explanation: "New Favorite", mediaType: .image, serviceVersion: "V1", title: "Title 3", url: "https://example.com/3")

        viewModel.addFavorite(item)

        XCTAssertTrue(viewModel.isFavorite(item))
        XCTAssertEqual(viewModel.favorites.count, 1)
        XCTAssertTrue(favoritesManagerMock.savedFavorites.contains { $0.id == item.id })
    }

    func testRemoveFavorite() {
        let item = CosmoModel(date: "2025-02-15", explanation: "To Remove", mediaType: .image, serviceVersion: "V1", title: "Title 4", url: "https://example.com/4")
        viewModel.addFavorite(item)

        viewModel.removeFavorite(item)

        XCTAssertFalse(viewModel.isFavorite(item))
        XCTAssertTrue(viewModel.favorites.isEmpty)
        XCTAssertTrue(favoritesManagerMock.removedFavorites.contains(item.id))
    }

    func testToggleFavorite() {
        let item = CosmoModel(date: "2025-02-16", explanation: "Toggle", mediaType: .video, serviceVersion: "V1", title: "Title 5", url: "https://example.com/5")

        viewModel.toggleFavorite(item)
        XCTAssertTrue(viewModel.isFavorite(item))
        XCTAssertTrue(favoritesManagerMock.savedFavorites.contains { $0.id == item.id })

        viewModel.toggleFavorite(item)
        XCTAssertFalse(viewModel.isFavorite(item))
        XCTAssertTrue(favoritesManagerMock.removedFavorites.contains(item.id))
    }

    func testRemoveFavorites() {
        let items = [
            CosmoModel(date: "2025-02-17", explanation: "Batch 1", mediaType: .image, serviceVersion: "V1", title: "Title 6", url: "https://example.com/6"),
            CosmoModel(date: "2025-02-18", explanation: "Batch 2", mediaType: .video, serviceVersion: "V1", title: "Title 7", url: "https://example.com/7")
        ]
        items.forEach { viewModel.addFavorite($0) }

        viewModel.removeFavorites(["2025-02-17", "2025-02-18"])

        XCTAssertTrue(viewModel.favorites.isEmpty)
        XCTAssertTrue(favoritesManagerMock.removedFavorites.contains("2025-02-17"))
        XCTAssertTrue(favoritesManagerMock.removedFavorites.contains("2025-02-18"))
    }
}

class FavoritesManagerMock: FavoritesManaging {
    var favorites: [CosmoModel] = []
    var savedFavorites: [CosmoModel] = []
    var removedFavorites: [String] = []

    func getFavorites() -> [CosmoModel] {
        return favorites
    }

    func saveFavorite(_ item: CosmoModel) {
        savedFavorites.append(item)
    }

    func removeFavorite(_ item: CosmoModel) {
        removedFavorites.append(item.id)
    }

    func removeFavorites(_ ids: [String]) {
        removedFavorites.append(contentsOf: ids)
    }
}
