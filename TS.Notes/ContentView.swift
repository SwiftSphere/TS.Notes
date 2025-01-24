//
// ContentView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct ContentView: View {
    @StateObject private var noteStore = NoteStore()
    @State private var isAddingNote = false
    @State private var isAddingCategory = false
    @State private var searchQuery = ""
    @State private var selectedCategory: Category? = nil
    @State private var selectedNote: Note? = nil
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true

    var filteredNotes: [Note] {
        noteStore.searchNotes(query: searchQuery)
            .filter { selectedCategory == nil || $0.category == selectedCategory }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground).opacity(0.8),
                        Color(.secondarySystemBackground).opacity(0.8)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    SearchBar(text: $searchQuery)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Button(action: {
                                withAnimation {
                                    selectedCategory = nil
                                }
                            }) {
                                Text(Localization.shared.string(for: "all"))
                                    .font(.subheadline)
                                    .padding(10)
                                    .background(selectedCategory == nil ? Color.blue : Color(.systemGray5))
                                    .foregroundColor(selectedCategory == nil ? .white : Color.primary)
                                    .cornerRadius(10)
                                    .shadow(color: selectedCategory == nil ? .blue : .clear, radius: 10, x: 0, y: 0)
                            }

                            ForEach(noteStore.categories) { category in
                                Button(action: {
                                    withAnimation {
                                        selectedCategory = category
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: category.icon)
                                            .foregroundColor(category.color)
                                            .shadow(color: category.color, radius: 5, x: 0, y: 0)
                                        Text(category.name)
                                            .font(.subheadline)
                                    }
                                    .padding(10)
                                    .background(selectedCategory == category ? category.color.opacity(0.2) : Color(.systemGray5))
                                    .foregroundColor(selectedCategory == category ? category.color : Color.primary)
                                    .cornerRadius(10)
                                    .shadow(color: selectedCategory == category ? category.color : .clear, radius: 10, x: 0, y: 0)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)

                    List {
                        ForEach(filteredNotes) { note in
                            NoteCardView(note: note, noteStore: noteStore, selectedNote: $selectedNote)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                                .transition(.asymmetric(
                                    insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal: .move(edge: .top).combined(with: .opacity)
                                ))
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
            }
            .navigationTitle("TS.Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            isAddingNote = true
                        }) {
                            Label(Localization.shared.string(for: "add_note"), systemImage: "plus")
                        }

                        Button(action: {
                            isAddingCategory = true
                        }) {
                            Label(Localization.shared.string(for: "add_category"), systemImage: "folder.badge.plus")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $isAddingNote) {
                AddNoteView(noteStore: noteStore)
            }
            .sheet(isPresented: $isAddingCategory) {
                AddCategoryView(noteStore: noteStore)
            }
            .sheet(item: $selectedNote) { note in
                NoteDetailView(noteStore: noteStore, note: note)
            }
            .onAppear {
                noteStore.loadNotes()
                noteStore.loadCategories()

                if isFirstLaunch {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isFirstLaunch = false
                    }
                }
            }
        }
    }
}