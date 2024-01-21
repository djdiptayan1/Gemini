//
//  DisplayOutput.swift
//  Gemini
//
//  Created by Diptayan Jash on 20/12/23.
//

import Foundation
import SwiftUI

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isSent: Bool
}

struct DisplayOutput: View {
    @Binding var messages: [Message]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(messages) { message in
                    HStack {
                        if message.isSent {
                            Spacer()
                            Text(message.text)
                                .padding(8)
                                .foregroundColor(.white)
                                .background(message.text.isEmpty ? Color.clear : Color(.blue))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text(message.text)
                                .padding(8)
                                .foregroundColor(.white)
                                .background(message.text.isEmpty ? Color.clear : Color(.green))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
