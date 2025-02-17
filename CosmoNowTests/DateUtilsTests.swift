//
//  DateUtilsTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 17/02/25.
//

import Foundation
import XCTest
@testable import CosmoNow

class DateUtilsTests: XCTestCase {
    func testGetCurrentDate() {
        let expectedFormat = "yyyy-MM-dd"
        let formatter = DateFormatter()
        formatter.dateFormat = expectedFormat
        let expectedDate = formatter.string(from: Date())
        
        let result = DateUtils.getCurrentDate()
        
        XCTAssertEqual(result, expectedDate, "getCurrentDate() should return the current date in yyyy-MM-dd format")
    }
    
    func testFormatDateWithDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let testDate = Date(timeIntervalSince1970: 0)
        
        let result = DateUtils.formatDate(testDate)
        let expected = formatter.string(from: testDate)
        
        XCTAssertEqual(result, expected, "formatDate(Date) should return the date in yyyy-MM-dd format")
    }
    
    func testFormatDateWithValidString() {
        let input = "2025-02-13"
        let expectedOutput = "Feb 13, 2025"
        
        let result = DateUtils.formatDate(input)
        
        XCTAssertEqual(result, expectedOutput, "formatDate(String) should convert yyyy-MM-dd to medium style date format")
    }
    
    func testFormatDateWithInvalidString() {
        let input = "invalid-date"
        let result = DateUtils.formatDate(input)
        
        XCTAssertEqual(result, input, "formatDate(String) should return the input if the format is incorrect")
    }
}
