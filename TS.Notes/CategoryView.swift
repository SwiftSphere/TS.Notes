//
// CategoryView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct CategoryView: View {
    @Binding var selectedCategory: Category
    var categories: [Category]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories) { category in
                    CategoryButton(category: category, selectedCategory: $selectedCategory)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryButton: View {
    var category: Category
    @Binding var selectedCategory: Category

    var body: some View {
        Button(action: {
            selectedCategory = category
        }) {
            HStack {
                Image(systemName: category.icon)
                    .foregroundColor(category.color)
                    .shadow(color: category.color, radius: 5, x: 0, y: 0)
                Text(category.name)
                    .font(.subheadline)
            }
            .padding(10)
            .background(
                selectedCategory == category ? category.color.opacity(0.2) : Color.gray.opacity(0.2)
            )
            .foregroundColor(selectedCategory == category ? category.color : .primary)
            .cornerRadius(10)
            .shadow(color: selectedCategory == category ? category.color : .clear, radius: 10, x: 0, y: 0)
        }
    }
}