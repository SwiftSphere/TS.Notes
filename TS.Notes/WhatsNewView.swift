//
// WhatsNewView.swift
//
// Created by Anonym on 22.01.25
//

import SwiftUI

struct WhatsNewView: View {
    @Environment(\.dismiss) var dismiss
    @State private var releaseNotes: String = "Loading release notes..."

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

                ScrollView {
                    Text(releaseNotes)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .foregroundColor(.secondary)
                }

                Spacer()

                Button(action: {
                    dismiss()
                }) {
                    Text(Localization.shared.string(for: "got_it"))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(15)
                }
                .padding()
            }
            .padding()
            .background(Color(.systemBackground).opacity(0.8))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .onAppear {
            loadReleaseNotes()
        }
    }

    private func loadReleaseNotes() {
        guard let appVersion = getAppVersion() else {
            releaseNotes = "Failed to get app version."
            return
        }

        fetchReleases { releases in
            guard let releases = releases else {
                releaseNotes = "Failed to fetch releases."
                return
            }

            if let release = findRelease(for: appVersion, in: releases) {
                releaseNotes = release.body
            } else {
                releaseNotes = "No release notes found for version \(appVersion)."
            }
        }
    }

    private func getAppVersion() -> String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    private func fetchReleases(completion: @escaping ([GitHubRelease]?) -> Void) {
        let url = URL(string: "https://api.github.com/repos/your-username/your-repo/releases")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let releases = try JSONDecoder().decode([GitHubRelease].self, from: data)
                completion(releases)
            } catch {
                print("Failed to decode releases: \(error)")
                completion(nil)
            }
        }.resume()
    }

    private func findRelease(for version: String, in releases: [GitHubRelease]) -> GitHubRelease? {
        return releases.first { $0.tag_name == version }
    }
}

struct GitHubRelease: Codable {
    let tag_name: String
    let body: String
}
