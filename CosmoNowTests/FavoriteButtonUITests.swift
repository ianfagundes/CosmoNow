//
//  FavoriteButtonView.swift
//  CosmoNowUITests
//
//  Created by Ian Fagundes on 17/02/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import CosmoNow

class FavoriteButtonTests: XCTestCase {
    func testFavoriteButtonTogglesState() throws {
        let isFavorite = Binding<Bool>(wrappedValue: false)
        let button = FavoriteButton(isFavorite: isFavorite)

        let exp = expectation(description: "ViewInspector")
        ViewHosting.host(view: button)

        DispatchQueue.main.async {
            do {
                let view = try button.inspect().find(ViewType.Button.self)
                
                let imageView = try view.labelView().image()
                
                XCTAssertEqual(try imageView.actualImage().name(), "heart")
                XCTAssertEqual(try imageView.foregroundColor(), Color(#colorLiteral(red: 0.984, green: 0.988, blue: 0.89, alpha: 1.0)))

                try view.tap()
                
                DispatchQueue.main.async {
                    do {
                        XCTAssertTrue(isFavorite.wrappedValue)
                        let updatedView = try button.inspect().find(ViewType.Button.self)
                        let updatedImageView = try updatedView.labelView().image()
                        
                        XCTAssertEqual(try updatedImageView.actualImage().name(), "heart.fill")
                        XCTAssertEqual(try updatedImageView.foregroundColor(), Color.red)
                        exp.fulfill()
                    } catch {
                        XCTFail("Erro ao verificar estado após clique: \(error)")
                    }
                }
            } catch {
                XCTFail("Erro ao inspecionar o botão: \(error)")
            }
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
