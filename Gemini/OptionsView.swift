//
//  OptionsView.swift
//  Gemini
//
//  Created by Diptayan Jash on 20/12/23.
//

import Foundation
import SwiftUI

struct OptionsView: View {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    @Binding var modelName: String
    @Binding var maxOutputTokens: Double

    var body: some View {
        VStack {
            Picker("Options", selection: $modelName) {
                Text("Gemini Pro").tag("gemini-pro")
                Text("Gemini Pro Vision").tag("gemini-pro-vision")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .tint(.blue)
            .onChange(of: modelName) {
                generator.impactOccurred()
            }

            Text("Selected Model: \(modelName)")
                .padding()
                .fontWeight(.bold)
            VStack {
                Text("Max Output Tokens: \(Int(maxOutputTokens))")
                Slider(value: $maxOutputTokens, in: 1000 ... 32000, step: 100)
                    .padding(.horizontal)
                    .onChange(of: maxOutputTokens) {
                        generator.impactOccurred()
                    }
            }
        }
        .padding()
    }
}
