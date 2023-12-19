//
//  sendDataToGeminiAPI.swift
//  Gemini
//
//  Created by Diptayan Jash on 19/12/23.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI

struct GeminiAPI {
    
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyDDVko0UXgILxuH7ddXv988tpWtZ8Rvixs")
    
    func generateContent(inputText: String) async throws -> String {
            let response = try await model.generateContent(inputText)
            if let text = response.text {
                print(text)
                return text
            } else {
                throw GeminiError.noGeneratedText
            }
        }
    }

    enum GeminiError: Error {
        case noGeneratedText
    }
