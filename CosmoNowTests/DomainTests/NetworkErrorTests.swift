//
//  NetworkErrorTests.swift
//  CosmoNowTests
//
//  Created by Ian Fagundes on 17/02/25.
//

import Foundation
import XCTest
@testable import CosmoNow

final class NetworkErrorTests: XCTestCase {

    func testErrorDescriptions() {
        XCTAssertEqual(NetworkError.invalidURL.errorDescription, "A URL fornecida é inválida.")
        XCTAssertEqual(NetworkError.noData.errorDescription, "Nenhum dado foi recebido do servidor.")

        let decodingError = NetworkError.decodingError(NSError(domain: "test", code: 0, userInfo: nil))
        XCTAssertTrue(decodingError.errorDescription!.contains("Falha ao decodificar a resposta"))

        let statusCodeError = NetworkError.badStatusCode(404)
        XCTAssertEqual(statusCodeError.errorDescription, "Erro HTTP 404: Resposta inesperada do servidor.")

        let requestError = NetworkError.requestFailed(NSError(domain: "test", code: 0, userInfo: nil))
        XCTAssertTrue(requestError.errorDescription!.contains("Falha na requisição"))

        XCTAssertEqual(NetworkError.unknownError.errorDescription, "Ocorreu um erro desconhecido.")
    }
}
