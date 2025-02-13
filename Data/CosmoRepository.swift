//
//  CosmoRepository.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

final class CosmoRepository: CosmoRepositoryProtocol {
    private let service: CosmoServiceProtocol
    
    init(service: CosmoServiceProtocol) {
        self.service = service
    }
    
    func fetchCosmo(for date: String?) async throws -> CosmoModel {
        return try await service.fetchCosmo(for: date)
    }
}
