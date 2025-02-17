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
    @Published var isFavorite = false
    @Published var selectedDate: Date = Date()

    private let favoritesManager = FavoritesManager.shared
    private var loadingTask: Task<Void, Never>?

    init(getCosmoUseCase: GetCosmoUseCaseProtocol) {
        self.getCosmoUseCase = getCosmoUseCase
    }

    func fetchCosmo() async {
        if let task = loadingTask {
            print("Requisição já em andamento, ignorando nova chamada.")
            await task.value
            return
        }

        isLoading = true
        errorMessage = nil

        loadingTask = Task {
            defer { loadingTask = nil }
            do {
                let cosmoData = try await getCosmoUseCase.execute(for: DateUtils.formatDate(selectedDate))
                cosmo = cosmoData
                checkIfFavorite()
            } catch {
                errorMessage = "Erro ao carregar imagem. Tente novamente mais tarde."
            }
            isLoading = false
        }

        await loadingTask?.value
    }

    func toggleFavorite() {
        guard let cosmo = cosmo else { return }
        if isFavorite {
            favoritesManager.removeFavorite(CosmoModel(from: cosmo))
        } else {
            favoritesManager.saveFavorite(CosmoModel(from: cosmo))
        }
        isFavorite.toggle()
    }

    private func checkIfFavorite() {
        if let cosmo = cosmo {
            isFavorite = favoritesManager.isFavorite(CosmoModel(from: cosmo))
        }
    }
}
