//
// Note.swift
//
// Created by Anonym on 21.01.25
//

import Foundation
import SwiftUI

struct Note: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var category: Category
}

struct CustomCategory: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var icon: String
    var color: Color

    enum CodingKeys: String, CodingKey {
        case id, name, icon, color
    }

    init(id: UUID = UUID(), name: String, icon: String, color: Color) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode(String.self, forKey: .icon)
        let colorHex = try container.decode(String.self, forKey: .color)
        self.color = Color(hex: colorHex)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(icon, forKey: .icon)
        let colorHex = color.toHex()
        try container.encode(colorHex, forKey: .color)
    }
}

enum Category: Identifiable, Codable, Equatable {
    case personal
    case work
    case ideas
    case other
    case custom(CustomCategory)

    enum CodingKeys: String, CodingKey {
        case personal
        case work
        case ideas
        case other
        case custom
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(.personal) {
            self = .personal
        } else if container.contains(.work) {
            self = .work
        } else if container.contains(.ideas) {
            self = .ideas
        } else if container.contains(.other) {
            self = .other
        } else if container.contains(.custom) {
            let customContainer = try container.nestedContainer(keyedBy: CustomCodingKeys.self, forKey: .custom)
            let customCategory = try customContainer.decode(CustomCategory.self, forKey: ._0)
            self = .custom(customCategory)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .custom,
                in: container,
                debugDescription: "Неизвестный тип категории"
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .personal:
            try container.encode(Empty(), forKey: .personal)
        case .work:
            try container.encode(Empty(), forKey: .work)
        case .ideas:
            try container.encode(Empty(), forKey: .ideas)
        case .other:
            try container.encode(Empty(), forKey: .other)
        case .custom(let customCategory):
            var customContainer = container.nestedContainer(keyedBy: CustomCodingKeys.self, forKey: .custom)
            try customContainer.encode(customCategory, forKey: ._0)
        }
    }

    enum CustomCodingKeys: String, CodingKey {
        case _0
    }

    struct Empty: Codable {}

    var id: UUID {
        switch self {
        case .personal: return UUID(uuidString: "00000000-0000-0000-0000-000000000001")!
        case .work: return UUID(uuidString: "00000000-0000-0000-0000-000000000002")!
        case .ideas: return UUID(uuidString: "00000000-0000-0000-0000-000000000003")!
        case .other: return UUID(uuidString: "00000000-0000-0000-0000-000000000004")!
        case .custom(let customCategory): return customCategory.id
        }
    }

    var name: String {
        switch self {
        case .personal: return Localization.shared.string(for: "personal")
        case .work: return Localization.shared.string(for: "work")
        case .ideas: return Localization.shared.string(for: "ideas")
        case .other: return Localization.shared.string(for: "other")
        case .custom(let customCategory): return customCategory.name
        }
    }

    var icon: String {
        switch self {
        case .personal: return "person.fill"
        case .work: return "briefcase.fill"
        case .ideas: return "lightbulb.fill"
        case .other: return "ellipsis.circle.fill"
        case .custom(let customCategory): return customCategory.icon
        }
    }

    var color: Color {
        switch self {
        case .personal: return .blue
        case .work: return .green
        case .ideas: return .orange
        case .other: return .gray
        case .custom(let customCategory): return customCategory.color
        }
    }
}

extension Color {
    func toHex() -> String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0
        return String(format: "#%06x", rgb)
    }

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}