//
//  GetCosmoUseCaseProtocol.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

protocol GetCosmoUseCaseProtocol {
    func execute(for date: String?) async throws -> CosmoUseCaseModel
}
