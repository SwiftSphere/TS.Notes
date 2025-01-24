//
// SearchBar.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField(Localization.shared.string(for: "search"), text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(radius: 2)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}