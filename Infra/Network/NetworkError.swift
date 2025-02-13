//
//  NetworkError.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case badStatusCode(Int)
    case requestFailed(Error)
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "A URL fornecida é inválida."
        case .noData:
            return "Nenhum dado foi recebido do servidor."
        case .decodingError(let error):
            return "Falha ao decodificar a resposta: \(error.localizedDescription)"
        case .badStatusCode(let statusCode):
            return "Erro HTTP \(statusCode): Resposta inesperada do servidor."
        case .requestFailed(let error):
            return "Falha na requisição: \(error.localizedDescription)"
        case .unknownError:
            return "Ocorreu um erro desconhecido."
        }
    }
}
