//
//  NetworkManagerTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 17/02/25.
//

import Foundation
import XCTest
@testable import CosmoNow

final class NetworkManagerTests: XCTestCase {
    private var networkManager: NetworkManager!
    private var mockCacheManager: DataCacheManagerMock!
    private var mockURLSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        mockCacheManager = DataCacheManagerMock()
        mockURLSession = URLSessionMock()
        networkManager = NetworkManager(cacheManager: mockCacheManager, session: mockURLSession)
    }

    override func tearDown() {
        mockCacheManager = nil
        mockURLSession = nil
        networkManager = nil
        super.tearDown()
    }
    
    func testFetch_WithCachedData_ShouldReturnCachedResponse() async throws {
        let expectedData = TestModel(id: 1, name: "Teste")
        let encodedData = try JSONEncoder().encode(expectedData)
        mockCacheManager.cachedData = encodedData
        
        let result: TestModel = try await networkManager.fetch(url: URL(string: "https://mockurl.com")!, cacheKey: "testCacheKey")
        
        XCTAssertEqual(result.id, expectedData.id)
        XCTAssertEqual(result.name, expectedData.name)
    }
    
    func testFetch_WithNoCache_ShouldFetchAndCacheData() async throws {
        let expectedData = TestModel(id: 2, name: "Novo Teste")
        let encodedData = try JSONEncoder().encode(expectedData)
        
        mockURLSession.mockData = encodedData
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "https://mockurl.com")!,
                                                      statusCode: 200,
                                                      httpVersion: nil,
                                                      headerFields: nil)

        let result: TestModel = try await networkManager.fetch(url: URL(string: "https://mockurl.com")!, cacheKey: "testCacheKey")

        XCTAssertEqual(result.id, expectedData.id)
        XCTAssertEqual(result.name, expectedData.name)
    }
    
    func testRequest_WithInvalidStatusCode_ShouldThrowBadStatusCodeError() async {
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "https://mockurl.com")!,
                                                      statusCode: 500,                                                       httpVersion: nil,
                                                      headerFields: nil)

        do {
            let _: TestModel = try await networkManager.request(url: URL(string: "https://mockurl.com")!, method: "GET")
            XCTFail("A requisição deveria ter falhado com um erro de status code")
        } catch NetworkError.badStatusCode(let statusCode) {
            XCTAssertEqual(statusCode, 500)
        } catch {
            XCTFail("Erro inesperado: \(error)")
        }
    }
    
    func testRequest_WithInvalidData_ShouldThrowDecodingError() async {
        mockURLSession.mockData = Data("invalid json".utf8)
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "https://mockurl.com")!,
                                                      statusCode: 200,
                                                      httpVersion: nil,
                                                      headerFields: nil)

        do {
            let _: TestModel = try await networkManager.request(url: URL(string: "https://mockurl.com")!, method: "GET")
            XCTFail("A requisição deveria ter falhado com erro de decodificação")
        } catch NetworkError.decodingError {
            XCTAssertTrue(true) // O erro esperado é `decodingError`
        } catch {
            XCTFail("Erro inesperado: \(error)")
        }
    }
}

// MARK: - Mocks

final class URLSessionMock: URLSessionProtocol {
    var mockData: Data?
    var mockResponse: HTTPURLResponse?
    var mockError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }

        guard let response = mockResponse else {
            throw NetworkError.unknownError
        }

        return (mockData ?? Data(), response)
    }
}
final class DataCacheManagerMock: DataCacheManagerProtocol {
    var cachedData: Data?

    func getCachedData(for key: String) -> Data? {
        return cachedData
    }

    func saveData(_ data: Data, for key: String) {
        cachedData = data
    }
}

// MARK: - Model

struct TestModel: Codable, Equatable {
    let id: Int
    let name: String
}
