//
//  File.swift
//  ModalPresentation
//
//  Created by Jorge Benavides Ojinaga on 10/04/25.
//

import SwiftUI

struct BlurShapeBackground: View {
    // Customizable properties
    var primaryColor: Color
    var secondaryColor: Color
    var blurRadius: CGFloat
    var animationSpeed: Double

    // State for animation
    @State private var animateGradient = false
    @State private var movingOffset = false

    init(
        primaryColor: Color = .blue,
        secondaryColor: Color = .purple,
        blurRadius: CGFloat = 60,
        animationSpeed: Double = 3
    ) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.blurRadius = blurRadius
        self.animationSpeed = animationSpeed
    }

    var body: some View {
        ZStack {
            // Animated gradient shapes
            ZStack {
                Circle()
                    .fill(primaryColor.opacity(0.8))
                    .frame(width: 300, height: 300)
                    .offset(x: movingOffset ? 50 : -50, y: movingOffset ? -100 : 100)
                    .blur(radius: blurRadius)

                // Second blob
                Circle()
                    .fill(secondaryColor.opacity(0.8))
                    .frame(width: 250, height: 250)
                    .offset(x: movingOffset ? -100 : 100, y: movingOffset ? 50 : -50)
                    .blur(radius: blurRadius)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            // Begin animations
            withAnimation(.easeInOut(duration: animationSpeed).repeatForever(autoreverses: true)) {
                movingOffset.toggle()
            }
            withAnimation(.linear(duration: animationSpeed * 2).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

// MARK: - Usage Examples

#Preview("Default Style") {
    ZStack {
        // Default blur shape background
        BlurShapeBackground()

        // Content
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .fontWeight(.bold)
            Button(action: {
                // Your action here
            }) {
                Text("Get Started")
                    .fontWeight(.semibold)
                    .padding()
                    .background(
                        Capsule()
                            .fill(.ultraThinMaterial)
                    )
            }
            .padding(.top, 20)
        }
    }
}

#Preview("Custom Style") {
    ZStack {
        // Custom blur shape background
        BlurShapeBackground(
            primaryColor: .yellow,
            secondaryColor: .green,
            blurRadius: 80,
            animationSpeed: 5
        )

        // Your content here
        Text("Custom Blur")
            .font(.title)
            .fontWeight(.bold)
    }
}
