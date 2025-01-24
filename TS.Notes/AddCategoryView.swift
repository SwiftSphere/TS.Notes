//
// AddCategoryView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var noteStore: NoteStore

    @State private var name = ""
    @State private var icon = ""
    @State private var color = Color.blue

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(Localization.shared.string(for: "category_name"))) {
                    TextField(Localization.shared.string(for: "category_name"), text: $name)
                }
                Section(header: Text(Localization.shared.string(for: "icon"))) {
                    TextField(Localization.shared.string(for: "icon"), text: $icon)
                }
                Section(header: Text(Localization.shared.string(for: "color"))) {
                    ColorPicker(Localization.shared.string(for: "color"), selection: $color)
                }
            }
            .navigationTitle(Localization.shared.string(for: "new_category"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(Localization.shared.string(for: "cancel")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(Localization.shared.string(for: "save")) {
                        let newCategory = CustomCategory(name: name, icon: icon, color: color)
                        noteStore.addCategory(category: .custom(newCategory))
                        dismiss()
                    }
                    .disabled(name.isEmpty || icon.isEmpty)
                }
            }
        }
    }
}