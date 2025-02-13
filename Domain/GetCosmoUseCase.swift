//
//  GetCosmoUseCase.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

class GetCosmoUseCase: GetCosmoUseCaseProtocol {
    private let repository: CosmoServiceProtocol

    init(repository: CosmoServiceProtocol) {
        self.repository = repository
    }

    func execute(for date: String?) async throws -> CosmoModel {
        return try await repository.fetchCosmo(for: date)
    }
}
