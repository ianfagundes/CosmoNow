//
//  LaunchScreenView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 15/02/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var opacity = 0.0
    @State private var scale: CGFloat = 0.8

    var body: some View {
        ZStack {
            Color(ThemeManager.primaryColor)
                .ignoresSafeArea()

            VStack {
                Image("cosmonow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white.opacity(0.7), lineWidth: 3))
                    .shadow(radius: 8)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            scale = 1.0
                        }
                    }

                Spacer().frame(height: 20)

                Text("The truth is out there")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                    .italic()
                    .shadow(radius: 5)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5).delay(0.5)) {
                            opacity = 1.0
                        }
                    }
            }
        }
    }
}
