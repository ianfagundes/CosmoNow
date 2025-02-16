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

import Foundation
import SwiftUI

struct CosmoView: View {
    @EnvironmentObject var viewModel: CosmoViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            } else if let cosmo = viewModel.cosmo {
                CosmoDetailView(cosmo: CosmoModel(from: cosmo), favoritesViewModel: favoritesViewModel)
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
        .onAppear {
            Task {
                if viewModel.cosmo == nil {
                    await viewModel.fetchCosmo()
                }
            }
        }
    }
}
