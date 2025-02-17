//
//  ContentViewUITests.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 17/02/25.
//

import XCTest

final class ContentViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("UI_TEST_MODE")
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMainTabViewIsLoaded() throws {
        let cosmoTab = app.tabBars.buttons.element(boundBy: 0)
        let favoritesTab = app.tabBars.buttons.element(boundBy: 2)

        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate, evaluatedWith: cosmoTab, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: favoritesTab, handler: nil)
        
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertTrue(cosmoTab.exists, "O botão da aba Cosmo não foi encontrado.")
        XCTAssertTrue(favoritesTab.exists, "O botão da aba de Favoritos não foi encontrado.")
    }

    func testSwitchBetweenTabs() throws {
        let cosmoTab = app.tabBars.buttons.element(boundBy: 0)
        let favoritesTab = app.tabBars.buttons.element(boundBy: 2)

        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: cosmoTab, handler: nil)
        expectation(for: existsPredicate, evaluatedWith: favoritesTab, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)

        favoritesTab.tap()
        expectation(for: NSPredicate(format: "isSelected == true"), evaluatedWith: favoritesTab, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(favoritesTab.isSelected, "Esperado que a aba Favoritos esteja ativa após o tap.")

        cosmoTab.tap()
        expectation(for: NSPredicate(format: "isSelected == true"), evaluatedWith: cosmoTab, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertTrue(cosmoTab.isSelected, "Esperado que a aba Cosmo esteja ativa novamente.")
    }
}
