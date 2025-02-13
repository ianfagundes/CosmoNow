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

    func execute(for date: String?) async throws -> CosmoModel {
        let finalDate = date ?? DateUtils.getCurrentDate()

        do {
            return try await repository.fetchCosmo(for: finalDate)
        } catch {
            print("Erro ao buscar CosmoModel: \(error.localizedDescription)")
            throw error
        }
    }
}
