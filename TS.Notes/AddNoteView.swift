//
// AddNoteView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var noteStore: NoteStore

    @State private var title = ""
    @State private var content = ""
    @State private var category: Category = .personal

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Localization.shared.string(for: "title")).font(.headline)) {
                    TextField(Localization.shared.string(for: "title"), text: $title)
                }
                Section(header: Text(Localization.shared.string(for: "content")).font(.headline)) {
                    TextField(Localization.shared.string(for: "content"), text: $content)
                }
                Section(header: Text(Localization.shared.string(for: "category")).font(.headline)) {
                    CategoryView(selectedCategory: $category, categories: noteStore.categories)
                }
            }
            .navigationTitle(Localization.shared.string(for: "new_note"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(Localization.shared.string(for: "cancel")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(Localization.shared.string(for: "save")) {
                        noteStore.addNote(title: title, content: content, category: category)
                        dismiss()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}