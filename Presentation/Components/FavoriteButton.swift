//
//  FavoriteButton.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 14/02/25.
//

import Foundation
import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    let toggleAction: () -> Void

    var body: some View {
        Button(action: {
            toggleAction()
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(isFavorite ? .red : Color(#colorLiteral(red: 0.984, green: 0.988, blue: 0.89, alpha: 1.0)))
                .padding(10)
                .background(Color.black.opacity(0.4))
                .clipShape(Circle())
        }
        .padding([.trailing, .bottom], 12)
    }
}
