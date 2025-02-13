//
//  CosmoRepositoryProtocol.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

protocol CosmoRepositoryProtocol {
    func fetchCosmo(for date: String?) async throws -> CosmoModel
}
