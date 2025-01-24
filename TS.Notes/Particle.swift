//
// Particle.swift
//
// Created by Anonym on 22.01.25
//

import SwiftUI
import CoreGraphics

struct Particle: Identifiable {
    let id: UUID
    var size: CGFloat
    var position: CGPoint
    var opacity: Double
    var glowRadius: CGFloat = 10
}