//
// WhatsNewView.swift
//
// Created by Anonym on 22.01.25
//

import SwiftUI

struct WhatsNewView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.9)
                .blur(radius: 10)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text(Localization.shared.string(for: "whats_new"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.primary)

                Text("Here are the latest updates and features in TS.Notes:")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.secondary)

                Text("• New category management")
                    .font(.body)
                    .padding(2)
                    .foregroundColor(.secondary)
                Text("• Improved note editing")
                    .font(.body)
                    .padding(2)
                    .foregroundColor(.secondary)
                Text("• Enhanced search functionality")
                    .font(.body)
                    .padding(2)
                    .foregroundColor(.secondary)

                Spacer()

                Link(destination: URL(string: "https://github.com/your-username/your-repo")!) {
                    HStack {
                        Image(systemName: "arrow.up.right.square")
                            .font(.headline)
                        Text(Localization.shared.string(for: "visit_github"))
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5)) // Более темный серый
                    .cornerRadius(15)
                }
                .padding(.horizontal)

                Button(action: {
                    dismiss()
                }) {
                    Text(Localization.shared.string(for: "got_it"))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.5)) // Более темный серый
                        .cornerRadius(15)
                }
                .padding()
            }
            .padding()
            .background(Color(.systemBackground).opacity(0.8))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .transition(.opacity)
    }
}