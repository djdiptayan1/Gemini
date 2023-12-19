//
//  SendButton.swift
//  Gemini
//
//  Created by Diptayan Jash on 19/12/23.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI

struct SendButton: View {
    @Binding var inputText: String
    @Binding var outputText: String
    @Binding var SentText: String
    
    let generator = UIImpactFeedbackGenerator(style: .heavy)

    var body: some View {
        Button(action: {
            generator.impactOccurred()
            if !inputText.trimmingCharacters(in: .whitespaces).isEmpty {
                Task {
                    do {
                        SentText = inputText
                        let inputfeed = inputText
                        inputText = ""
                        let geminiAPI = GeminiAPI()
                        outputText = try await geminiAPI.generateContent(inputText: inputfeed)
                    } catch {
                        print("Failed to generate content: \(error)")
                    }
                }
                outputText = ""
            }
        }) {
            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(5)
        }
        .background(Color.blue)
        .cornerRadius(50)
    }
}
