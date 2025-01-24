//
// NoteStore.swift
//
// Created by Anonym on 21.01.25
//

import Foundation

class NoteStore: ObservableObject {
    @Published var notes: [Note] = []
    @Published var categories: [Category] = [.personal, .work, .ideas, .other]

    func addNote(title: String, content: String, category: Category) {
        let newNote = Note(title: title, content: content, category: category)
        notes.append(newNote)
        saveNotes()
    }

    func updateNote(id: UUID, title: String, content: String, category: Category) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes[index].title = title
            notes[index].content = content
            notes[index].category = category
            saveNotes()
        }
    }

    func deleteNote(at indexSet: IndexSet) {
        notes.remove(atOffsets: indexSet)
        saveNotes()
    }

    func searchNotes(query: String) -> [Note] {
        if query.isEmpty {
            return notes
        }
        return notes.filter { $0.title.localizedCaseInsensitiveContains(query) || $0.content.localizedCaseInsensitiveContains(query) }
    }

    func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }

    func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: "notes"),
           let decoded = try? JSONDecoder().decode([Note].self, from: data) {
            notes = decoded
        }
    }

    func addCategory(category: Category) {
        categories.append(category)
        saveCategories()
    }

    func saveCategories() {
        if let encoded = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encoded, forKey: "categories")
        }
    }

    func loadCategories() {
        if let data = UserDefaults.standard.data(forKey: "categories"),
           let decoded = try? JSONDecoder().decode([Category].self, from: data) {
            categories = decoded
        }
    }
}