//
// NoteDetailView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct NoteDetailView: View {
    @ObservedObject var noteStore: NoteStore
    var note: Note

    @State private var title: String
    @State private var content: String
    @State private var isEditing = false

    init(noteStore: NoteStore, note: Note) {
        self.noteStore = noteStore
        self.note = note
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.content)
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if isEditing {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(Localization.shared.string(for: "title"))
                                .font(.headline)
                            TextField(Localization.shared.string(for: "title"), text: $title)
                                .font(.title)
                                .padding(.bottom, 8)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text(Localization.shared.string(for: "content"))
                                .font(.headline)
                            TextField(Localization.shared.string(for: "content"), text: $content)
                                .font(.body)
                        }
                    } else {
                        HStack {
                            Image(systemName: note.category.icon)
                                .foregroundColor(note.category.color)
                                .shadow(color: note.category.color, radius: 10, x: 0, y: 0)
                            Text(note.title)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .shadow(color: note.category.color, radius: 5, x: 0, y: 0)
                        }
                        .padding(.bottom, 8)

                        Text(note.content)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                    }

                    Text(note.category.name)
                        .font(.caption)
                        .foregroundColor(note.category.color)
                        .padding(5)
                        .background(note.category.color.opacity(0.2))
                        .cornerRadius(5)
                        .shadow(color: note.category.color, radius: 5, x: 0, y: 0)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditing {
                        Button(Localization.shared.string(for: "done")) {
                            noteStore.updateNote(id: note.id, title: title, content: content, category: note.category)
                            isEditing = false
                        }
                    } else {
                        Button(action: {
                            isEditing = true
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
}