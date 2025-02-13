//
//  CosmoView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

//
//  CosmoView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import SwiftUI

struct CosmoView: View {
    @StateObject private var viewModel = CosmoViewModel(
        getCosmoUseCase: GetCosmoUseCase(repository: CosmoRepository(service: CosmoService()))
    )

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if viewModel.isLoading && viewModel.cosmo == nil {
                    ProgressView()
                        .scaleEffect(1.5)
                } else if let cosmo = viewModel.cosmo {
                    VStack(spacing: 10) {
                        Text(cosmo.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Text(cosmo.date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    if cosmo.mediaType == .image {
                        CachedAsyncImage(url:  cosmo.mediaURL?.absoluteString ?? "")
                            .frame(height: 300)
                            .cornerRadius(10)
                            .padding()
                    } else {
                        MediaView(mediaType: cosmo.mediaType, mediaURL: cosmo.mediaURL)
                            .frame(height: 300)
                            .cornerRadius(10)
                            .padding()
                    }

                    ScrollView {
                        Text(cosmo.explanation)
                            .font(.body)
                            .padding(.horizontal)
                    }
                    .frame(maxHeight: 200)

                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Tentar Novamente") {
                            Task {
                                await viewModel.fetchCosmo()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
            }
            .task {
                await viewModel.fetchCosmo()
            }
        }
    }
}

#Preview {
    CosmoView()
}
