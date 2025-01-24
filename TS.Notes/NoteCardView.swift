//
// NoteCardView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct NoteCardView: View {
    var note: Note
    @ObservedObject var noteStore: NoteStore
    @Binding var selectedNote: Note?

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: note.category.icon)
                        .foregroundColor(note.category.color)
                        .shadow(color: note.category.color, radius: 10, x: 0, y: 0)
                    Text(note.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .shadow(color: note.category.color, radius: 5, x: 0, y: 0)
                }
                Text(note.content)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                Text(note.category.name)
                    .font(.caption)
                    .foregroundColor(note.category.color)
                    .padding(5)
                    .background(note.category.color.opacity(0.2))
                    .cornerRadius(5)
                    .shadow(color: note.category.color, radius: 5, x: 0, y: 0)
            }
            Spacer()

            Button(action: {
                withAnimation {
                    if let index = noteStore.notes.firstIndex(where: { $0.id == note.id }) {
                        noteStore.deleteNote(at: IndexSet(integer: index))
                    }
                }
            }) {
                Image(systemName: "trash.circle.fill")
                    .font(.title2)
                    .foregroundColor(.red)
                    .shadow(color: .red, radius: 10, x: 0, y: 0)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color(.secondarySystemBackground).opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 5)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedNote = note
        }
    }
}