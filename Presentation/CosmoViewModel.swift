//
//  CosmoViewModel.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import Foundation

class CosmoViewModel: ObservableObject {
    private let GetCosmoUseCase: GetCosmoUseCaseProtocol

    @Published var cosmo: CosmoModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedDate: String? = nil

    init(getCosmoUseCase: GetCosmoUseCaseProtocol) {
        self.GetCosmoUseCase = getCosmoUseCase
    }

    func fetchCosmo() async {
        isLoading = true
        errorMessage = nil

        do {
            let cosmoData = try await GetCosmoUseCase.execute(for: selectedDate)

            DispatchQueue.main.async {
                
                self.cosmo = cosmoData
                self.isLoading = false
            }

        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Erro ao carregar imagem. Tente novamente mais tarde."
            }
        }
        isLoading = false
    }
}
