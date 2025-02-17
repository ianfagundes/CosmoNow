//
//  FavoritesManagerTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 17/02/25.
//

import XCTest
@testable import CosmoNow

class FavoritesManagerTests: XCTestCase {
    var favoritesManager: FavoritesManager!
    let defaults = UserDefaults(suiteName: "testDefaults")!

    override func setUp() {
        super.setUp()
        defaults.removePersistentDomain(forName: "testDefaults")
        favoritesManager = FavoritesManager(userDefaults: defaults)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: "testDefaults")
        super.tearDown()
    }

    func testSaveFavorite() {
        let item = CosmoModel(date: "2025-02-14", explanation: "New Favorite", mediaType: .image, serviceVersion: "V1", title: "Title 1", url: "https://example.com/1")

        favoritesManager.saveFavorite(item)
        let savedFavorites = favoritesManager.getFavorites()

        XCTAssertTrue(savedFavorites.contains { $0.id == item.id })
    }

    func testRemoveFavorite() {
        let item = CosmoModel(date: "2025-02-15", explanation: "To Remove", mediaType: .image, serviceVersion: "V1", title: "Title 2", url: "https://example.com/2")
        favoritesManager.saveFavorite(item)

        favoritesManager.removeFavorite(item)
        let savedFavorites = favoritesManager.getFavorites()

        XCTAssertFalse(savedFavorites.contains { $0.id == item.id })
    }

    func testRemoveFavorites() {
        let items = [
            CosmoModel(date: "2025-02-16", explanation: "Batch 1", mediaType: .image, serviceVersion: "V1", title: "Title 3", url: "https://example.com/3"),
            CosmoModel(date: "2025-02-17", explanation: "Batch 2", mediaType: .video, serviceVersion: "V1", title: "Title 4", url: "https://example.com/4")
        ]
        items.forEach { favoritesManager.saveFavorite($0) }

        favoritesManager.removeFavorites(["2025-02-16", "2025-02-17"])
        let savedFavorites = favoritesManager.getFavorites()

        XCTAssertTrue(savedFavorites.isEmpty)
    }

    func testIsFavorite() {
        let item = CosmoModel(date: "2025-02-18", explanation: "Check Favorite", mediaType: .image, serviceVersion: "V1", title: "Title 5", url: "https://example.com/5")
        favoritesManager.saveFavorite(item)

        XCTAssertTrue(favoritesManager.isFavorite(item))

        favoritesManager.removeFavorite(item)
        XCTAssertFalse(favoritesManager.isFavorite(item))
    }
}
