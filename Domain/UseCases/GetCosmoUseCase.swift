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

        do {
            let cosmo = try await repository.fetchCosmo(for: finalDate)

            let mediaType = MediaManager.getMediaType(from: cosmo.mediaType)
            let mediaURL = MediaManager.getFormattedURL(from: cosmo.url)

            return CosmoUseCaseModel(
                date: cosmo.date,
                title: cosmo.title,
                explanation: cosmo.explanation,
                mediaType: mediaType,
                mediaURL: mediaURL
            )
        } catch {
            print("Erro ao buscar CosmoModel: \(error.localizedDescription)")
            throw error
        }
    }
}
