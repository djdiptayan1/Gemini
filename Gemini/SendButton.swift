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
    @State var modelName: String
    
    @Binding var messages: [Message]

    let generationConfig = GenerationConfig(maxOutputTokens: 35000) //for chating only
    // Define the chat history
    let history = [
        ModelContent(role: "user", parts: "Hello, I am Diptayan. I am a CSE undergrad at SRM Institute of science and Technology. I love coding, playing video games. My portfolio website is- https://djdiptayan.in/"),
        ModelContent(role: "model", parts: "Great to meet you. What would you like to know?")
    ]

    
    let generator = UIImpactFeedbackGenerator(style: .heavy)

    var body: some View {
        Button(action: {
            generator.impactOccurred()
            if !inputText.trimmingCharacters(in: .whitespaces).isEmpty {
                Task {
                    do {
                        messages.append(Message(text: inputText, isSent: true))
                        SentText = inputText
                        let inputfeed = inputText
                        inputText = ""
//                        let geminiAPI = GeminiAPI(modelName: modelName) //normal
                        var geminiAPI = GeminiAPI(modelName: modelName, generationConfig: generationConfig) //multi chat
                        geminiAPI.startChat(history: history) // Initialize the chat
//                        outputText = try await geminiAPI.generateContent(inputText: inputfeed) //normal
                        outputText = try await geminiAPI.sendMessage(inputfeed) //multi chat
                        
                        messages.append(Message(text: outputText, isSent: false))
                        
                        generator.impactOccurred()
                    } catch {
                        print("Failed to generate content: \(error)")

                        if case let GoogleGenerativeAI.GenerateContentError.responseStoppedEarly(_, response) = error {
                            if let candidate = response.candidates.first,
                               let content = candidate.content.parts.first(where: { $0.text != nil }) {
                                outputText = content.text!
                                messages.append(Message(text: outputText, isSent: false))
                                print(outputText)
                            }
                        } else {
                            outputText = "Content blocked for safety reasons."
                            messages.append(Message(text: outputText, isSent: false))
                        }
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
