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

    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Pick a date:")
                .font(.headline)
                .padding()

            DatePicker(
                "Data:",
                selection: $viewModel.selectedDate,
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding()

            Button("Confirm") {
                Task {
                    await viewModel.fetchCosmo()
                }
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}
