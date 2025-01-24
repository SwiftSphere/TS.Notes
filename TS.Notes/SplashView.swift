//
// SplashView.swift
//
// Created by Anonym on 21.01.25
//

import SwiftUI

struct SplashView: View {
    @State private var isTextVisible = false
    @State private var particles: [Particle] = []
    @State private var showWhatsNew = false
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    @State private var isActive = false
    @State private var showLanguageSelection = false

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            ForEach(particles) { particle in
                Circle()
                    .fill(Color.white)
                    .frame(width: particle.size, height: particle.size)
                    .position(particle.position)
                    .opacity(particle.opacity)
                    .shadow(color: .white, radius: particle.glowRadius, x: 0, y: 0)
            }

            if isTextVisible {
                VStack(spacing: 8) {
                    Text(Localization.shared.string(for: "welcome_message"))
                        .font(.system(size: 20, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(isTextVisible ? 1 : 0)
                        .transition(.opacity)
                        .shadow(color: .white, radius: 10, x: 0, y: 0)

                    Text("TS.Notes")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(isTextVisible ? 1 : 0)
                        .transition(.opacity)
                        .shadow(color: .white, radius: 10, x: 0, y: 0)
                }
            }
        }
        .onAppear {
            if !isFirstLaunch {
                isActive = true
                return
            }

            createParticles()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 2)) {
                    moveParticlesToTextPosition()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 1)) {
                    isTextVisible = true
                }
            }
        }
        .onTapGesture {
            if isFirstLaunch {
                withAnimation(.easeInOut(duration: 1)) {
                    showLanguageSelection = true
                }
            }
        }
        .fullScreenCover(isPresented: $showLanguageSelection, onDismiss: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showWhatsNew = true
                isFirstLaunch = false
            }
        }) {
            LanguageSelectionView()
                .transition(.opacity)
        }
        .fullScreenCover(isPresented: $showWhatsNew, onDismiss: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isActive = true
            }
        }) {
            WhatsNewView()
                .transition(.opacity)
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
                .transition(.opacity)
        }
    }

    private func createParticles() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        for _ in 0..<200 {
            let size = CGFloat.random(in: 1...3)
            let position = CGPoint(
                x: CGFloat.random(in: 0...screenWidth),
                y: CGFloat.random(in: 0...screenHeight)
            )
            particles.append(Particle(id: UUID(), size: size, position: position, opacity: 1, glowRadius: 5))
        }
    }

    private func moveParticlesToTextPosition() {
        let textPosition = CGPoint(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 2 - 50
        )

        for index in particles.indices {
            let randomOffset = CGPoint(
                x: CGFloat.random(in: -50...50),
                y: CGFloat.random(in: -50...50)
            )
            particles[index].position = CGPoint(
                x: textPosition.x + randomOffset.x,
                y: textPosition.y + randomOffset.y
            )
            particles[index].opacity = 0
        }
    }
}