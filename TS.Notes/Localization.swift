//
// Localization.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

enum Language: String, CaseIterable {
    case english = "en"
    case russian = "ru"
    case chinese = "zh"
}

struct Localization {
    static let shared = Localization()

    @AppStorage("selectedLanguage") private var selectedLanguage: String = "en"

    private var currentLanguage: Language {
        Language(rawValue: selectedLanguage) ?? .english
    }

    func string(for key: String) -> String {
        switch currentLanguage {
        case .english:
            return englishTranslations[key] ?? key
        case .russian:
            return russianTranslations[key] ?? key
        case .chinese:
            return chineseTranslations[key] ?? key
        }
    }

    private let englishTranslations: [String: String] = [
        "welcome_message": "Welcome to TS.Notes",
        "add_note": "Add Note",
        "add_category": "Add Category",
        "title": "Title",
        "content": "Content",
        "category": "Category",
        "save": "Save",
        "cancel": "Cancel",
        "edit_note": "Edit Note",
        "new_note": "New Note",
        "search": "Search",
        "all": "All",
        "personal": "Personal",
        "work": "Work",
        "ideas": "Ideas",
        "other": "Other",
        "delete": "Delete",
        "whats_new": "What's New",
        "visit_github": "Visit GitHub",
        "got_it": "Got it!",
        "new_category": "New Category",
        "category_name": "Category Name",
        "icon": "Icon",
        "color": "Color",
        "select_language": "Select Language",
    ]

    private let russianTranslations: [String: String] = [
        "welcome_message": "Добро пожаловать в TS.Notes",
        "add_note": "Добавить заметку",
        "add_category": "Добавить категорию",
        "title": "Заголовок",
        "content": "Содержимое",
        "category": "Категория",
        "save": "Сохранить",
        "cancel": "Отмена",
        "edit_note": "Редактировать заметку",
        "new_note": "Новая заметка",
        "search": "Поиск",
        "all": "Все",
        "personal": "Личное",
        "work": "Работа",
        "ideas": "Идеи",
        "other": "Другое",
        "delete": "Удалить",
        "whats_new": "Что нового",
        "visit_github": "Посетить GitHub",
        "got_it": "Понятно!",
        "new_category": "Новая категория",
        "category_name": "Название категории",
        "icon": "Иконка",
        "color": "Цвет",
        "select_language": "Выберите язык",
    ]

    private let chineseTranslations: [String: String] = [
        "welcome_message": "欢迎使用 TS.Notes",
        "add_note": "添加笔记",
        "add_category": "添加类别",
        "title": "标题",
        "content": "内容",
        "category": "类别",
        "save": "保存",
        "cancel": "取消",
        "edit_note": "编辑笔记",
        "new_note": "新笔记",
        "search": "搜索",
        "all": "全部",
        "personal": "个人",
        "work": "工作",
        "ideas": "想法",
        "other": "其他",
        "delete": "删除",
        "whats_new": "最新消息",
        "visit_github": "访问 GitHub",
        "got_it": "知道了！",
        "new_category": "新类别",
        "category_name": "类别名称",
        "icon": "图标",
        "color": "颜色",
        "select_language": "选择语言",
    ]
}