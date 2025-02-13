//
//  GetCosmoUseCase.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

class GetCosmoUseCase: GetCosmoUseCaseProtocol {
    private let repository: CosmoRepositoryProtocol

    init(repository: CosmoRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for date: String?) async throws -> CosmoUseCaseModel {
        let finalDate = date ?? DateUtils.getCurrentDate()
        let result = try await repository.fetchCosmo(for: finalDate)
        return CosmoUseCaseModel(from: result)
    }
}
