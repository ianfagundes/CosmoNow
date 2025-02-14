//
//  CachedImageViewModel.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 14/02/25.
//

import Foundation
import SwiftUI

@MainActor
class CachedImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    private var currentTask: Task<Void, Never>?

    func loadImage(from url: String) {
        guard !url.isEmpty else { return }
        currentTask?.cancel()

        image = nil
        isLoading = true

        currentTask = Task {
            if let cachedImage = ImageCacheManager.shared.getImage(for: url) {
                self.image = cachedImage
                self.isLoading = false
                return
            }

            do {
                let newImage = try await fetchImage(from: url)
                ImageCacheManager.shared.saveImage(newImage, for: url)
                self.image = newImage
            } catch {
                print("Erro ao carregar imagem: \(error.localizedDescription)")
            }

            isLoading = false
        }
    }

    private func fetchImage(from url: String) async throws -> UIImage {
        guard let imageUrl = URL(string: url) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: imageUrl)
        guard let downloadedImage = UIImage(data: data) else { throw URLError(.cannotDecodeRawData) }
        return downloadedImage
    }
}
