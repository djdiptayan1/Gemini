//
//  UserInput.swift
//  Gemini
//
//  Created by Diptayan Jash on 19/12/23.
//

import Foundation
import SwiftUI
struct UserInput: View {
    @Binding var inputText: String
    @Binding var outputText: String
    @Binding var SentText: String
    @Binding var showingImagePicker: Bool
    @Binding var inputImageData: Data
    

    var body: some View {
        HStack {
            TextField("Enter prompt", text: $inputText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                self.showingImagePicker = true
            }) {
                Image(systemName: "photo.badge.plus.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            SendButton(inputText: $inputText, outputText: $outputText, SentText: $SentText)
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 8, trailing: 10))
    }
}
