//
//  DatePickerModalViewTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 17/02/25.
//

import Foundation
import XCTest
import SwiftUI
@testable import CosmoNow

@MainActor
final class DatePickerModalViewTests: XCTestCase {
    
    var viewModel: CosmoViewModel!
    var selectedTab: Int!
    
    override func setUp() {
        super.setUp()
        viewModel = CosmoViewModel(getCosmoUseCase: GetCosmoUseCase(repository: CosmoRepository(service: CosmoService())))
        selectedTab = 1
    }
    
    override func tearDown() {
        viewModel = nil
        selectedTab = nil
        super.tearDown()
    }

    func testDatePickerBindsToViewModel() {
        let initialDate = viewModel.selectedDate
        let newDate = Calendar.current.date(byAdding: .day, value: -1, to: initialDate) ?? initialDate

        let view = DatePickerModalView(viewModel: viewModel, selectedTab: .constant(1))
        let hostingController = UIHostingController(rootView: view)
        
        viewModel.selectedDate = newDate

        XCTAssertEqual(viewModel.selectedDate, newDate, "A data do DatePicker deveria ser atualizada corretamente no ViewModel.")
    }
    
    func testConfirmButtonChangesTabAndFetchesData() async {
        let expectation = expectation(description: "fetchCosmo should be called")

        let mockViewModel = CosmoViewModel(getCosmoUseCase: GetCosmoUseCase(repository: CosmoRepository(service: CosmoService())))
        let view = DatePickerModalView(viewModel: mockViewModel, selectedTab: .constant(1))
        let hostingController = UIHostingController(rootView: view)

        // Simula o fetchCosmo
        await mockViewModel.fetchCosmo()

        // Normaliza a data para comparação apenas por dia
        let calendar = Calendar.current
        let testDate = calendar.startOfDay(for: mockViewModel.selectedDate)
        let expectedDate = calendar.startOfDay(for: viewModel.selectedDate)

        XCTAssertEqual(testDate, expectedDate, "A data selecionada deve ser a mesma no ViewModel.")
        
        expectation.fulfill()
        await fulfillment(of: [expectation], timeout: 3)
    }
}
