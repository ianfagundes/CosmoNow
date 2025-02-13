//
//  CachedAsyncImage.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: String

    @State private var image: UIImage?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .onAppear {
                        Task {
                            await loadImage()
                        }
                    }
            }
        }
    }

    private func loadImage() async {
        guard !url.isEmpty, let imageUrl = URL(string: url) else {
            print("URL inválida: \(url)")
            return
        }

        if let cachedImage = ImageCacheManager.shared.getImage(for: url) {
            image = cachedImage
            return
        }

        do {
            isLoading = true
            let (data, _) = try await URLSession.shared.data(from: imageUrl)
            guard let downloadedImage = UIImage(data: data) else { return }

            ImageCacheManager.shared.saveImage(downloadedImage, for: url)

            DispatchQueue.main.async {
                self.image = downloadedImage
                self.isLoading = false
            }
        } catch {
            print("Erro ao baixar imagem: \(error.localizedDescription)")
            isLoading = false
        }
    }
}
