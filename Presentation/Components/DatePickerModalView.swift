//
//  DatePickerModalView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import Foundation
import SwiftUI

struct DatePickerModalView: View {
    @ObservedObject var viewModel: CosmoViewModel
    @Binding var selectedTab: Int

    var body: some View {
        VStack {
            Text("Pick a date:")
                .foregroundColor(ThemeManager.primaryColor)
                .font(.headline)
                .padding()

            DatePicker(
                "Data:",
                selection: $viewModel.selectedDate,
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .accentColor(ThemeManager.primaryColor)
            .padding()

            Button(action: {
                selectedTab = 0
                Task {
                    await viewModel.fetchCosmo()
                }
            }) {
                Text("Confirm")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(ThemeManager.backgroundColor)
                    .background(ThemeManager.primaryColor)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .contentShape(Rectangle())
            }
            .padding()
        }
        .padding()
        .cornerRadius(15)
    }
}
