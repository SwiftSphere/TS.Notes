//
// LanguageSelectionView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct LanguageSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "en"

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Language Selection")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                Button(action: {
                    selectedLanguage = "en"
                    dismiss()
                }) {
                    Text("English")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.5)) // Более темный серый
                        .cornerRadius(15)
                }

                Button(action: {
                    selectedLanguage = "ru"
                    dismiss()
                }) {
                    Text("Русский (Russian)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.5)) // Более темный серый
                        .cornerRadius(15)
                }

                Button(action: {
                    selectedLanguage = "zh"
                    dismiss()
                }) {
                    Text("中文 (Chinese)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.5)) // Более темный серый
                        .cornerRadius(15)
                }
            }
            .padding()
        }
    }
}