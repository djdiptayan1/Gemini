//
//  ContentView.swift
//  Gemini
//
//  Created by Diptayan Jash on 19/12/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var outputText: String = ""
    @State private var SentText: String = ""

    @State private var inputImage: Image? = nil
    @State private var showingImagePicker = false
    @State private var inputImageData: Data = Data()

    @State private var isVisionModel: Bool = false
    @State private var modelName: String = "gemini-pro" // "gemini-pro" and "gemini-pro"

    @State var messages: [Message] = []

    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    ScrollView {
//                        DisplayOutput(SentText: $SentText, outputText: $outputText)
                       DisplayOutput(messages: $messages)
                        .frame(minWidth: 385)
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(2)

                    Spacer()

                    UserInput(inputText: $inputText, outputText: $outputText, SentText: $SentText, modelName: modelName, showingImagePicker: $showingImagePicker, inputImageData: $inputImageData, messages: $messages)
                        .id("InputText")

                }.navigationTitle("Gemini Pro")
                    .navigationBarTitleDisplayMode(.inline)
                    .foregroundStyle(Color(.label))
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImageData)
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }

    func loadImage() {
        guard let inputImage = UIImage(data: inputImageData) else { return }
        self.inputImage = Image(uiImage: inputImage)
    }
}

#Preview {
    ContentView()
}
