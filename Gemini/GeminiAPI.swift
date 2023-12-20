//
//  sendDataToGeminiAPI.swift
//  Gemini
//
//  Created by Diptayan Jash on 19/12/23.
//

//import Foundation
//import GoogleGenerativeAI
//import SwiftUI
//
//struct GeminiAPI {
//    @State var modelName: String
//
//    var model: GenerativeModel {
//        GenerativeModel(name: modelName, apiKey: "AIzaSyDDVko0UXgILxuH7ddXv988tpWtZ8Rvixs")
//    }
//
//    func generateContent(inputText: String) async throws -> String {
//        print(modelName)
//        let response = try await model.generateContent(inputText)
//        if let text = response.text {
//            print(text)
//            return text
//        } else {
//            throw GeminiError.noGeneratedText
//        }
//    }
//}
//
//enum GeminiError: Error {
//    case noGeneratedText
//}

//FOR MULTI CHAT
import Foundation
import GoogleGenerativeAI
import SwiftUI

struct GeminiAPI {
    var model: GenerativeModel
    var chat: Chat?

    init(modelName: String, generationConfig: GenerationConfig) {
        self.model = GenerativeModel(name: modelName, apiKey: "AIzaSyDDVko0UXgILxuH7ddXv988tpWtZ8Rvixs", generationConfig: generationConfig)
    }

    mutating func startChat(history: [ModelContent]) {
        self.chat = model.startChat(history: history)
    }

    func sendMessage(_ message: String) async throws -> String {
        guard let chat = self.chat else {
            throw GeminiError.chatNotInitialized
        }
        let response = try await chat.sendMessage(message)
        if let text = response.text {
            return text
        } else {
            throw GeminiError.noGeneratedText
        }
    }
}

enum GeminiError: Error {
    case chatNotInitialized
    case noGeneratedText
}
