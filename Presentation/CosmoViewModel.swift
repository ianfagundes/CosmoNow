//
//  CosmoViewModel.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

@MainActor
class CosmoViewModel: ObservableObject {
    private let getCosmoUseCase: GetCosmoUseCaseProtocol
    
    @Published var cosmo: CosmoUseCaseModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedDate: Date = Date() {
        didSet { Task { await fetchCosmo() } } 
    }

    init(getCosmoUseCase: GetCosmoUseCaseProtocol) {
        self.getCosmoUseCase = getCosmoUseCase
    }

    func fetchCosmo() async {
        isLoading = true
        errorMessage = nil

        let formattedDate = DateUtils.formatDate(selectedDate)
        
        do {
            let cosmoData = try await getCosmoUseCase.execute(for: formattedDate)
            self.cosmo = cosmoData
        } catch {
            self.errorMessage = "Erro ao carregar imagem. Tente novamente mais tarde."
        }

        isLoading = false
    }
}
