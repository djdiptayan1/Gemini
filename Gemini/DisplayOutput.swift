//
//  DisplayOutput.swift
//  Gemini
//
//  Created by Diptayan Jash on 20/12/23.
//

import Foundation
import SwiftUI

struct DisplayOutput: View {
    
    @Binding var SentText: String
    @Binding var outputText: String
    
    var body: some View {
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
}