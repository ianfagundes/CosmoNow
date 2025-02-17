//
//  CosmoNowApp.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 12/02/25.
//

import SwiftUI

@main
struct CosmoNowApp: App {
    @State private var showLaunchScreen = true

    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}
