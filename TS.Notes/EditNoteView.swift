//
// EditNoteView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var noteStore: NoteStore
    var note: Note

    @State private var title: String
    @State private var content: String
    @State private var category: Category

    init(noteStore: NoteStore, note: Note) {
        self.noteStore = noteStore
        self.note = note
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.content)
        _category = State(initialValue: note.category)
    }

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
            .navigationTitle(Localization.shared.string(for: "edit_note"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(Localization.shared.string(for: "save")) {
                        noteStore.updateNote(id: note.id, title: title, content: content, category: category)
                        dismiss()
                    }
                }
            }
        }
    }
}