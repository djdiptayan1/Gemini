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

    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(SentText)
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background(SentText.isEmpty ? Color.clear : Color(.blue))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }

                            HStack {
                                Spacer()
                                Text(outputText)
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background(outputText.isEmpty ? Color.clear : Color(.green))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        .padding()
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(5)

                    Spacer()

                    UserInput(inputText: $inputText, outputText: $outputText, SentText: $SentText, showingImagePicker: $showingImagePicker, inputImageData: $inputImageData)
                }
                .navigationTitle("Gemini Pro")
                .navigationBarTitleDisplayMode(.inline)
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
