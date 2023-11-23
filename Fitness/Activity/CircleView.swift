//
//  ActivityView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 15/11/23.
//


import SwiftUI

struct Arrow: View {
    private let beginning = CGPoint(x: 20, y: 20)
    
    var body: some View {
        return Path { p in
            p.move(to: beginning)
            p.addLine(to: CGPoint(x: 0, y: 20))
            
            p.move(to: beginning)
            p.addLine(to: CGPoint(x: 12, y:8))
            
            p.move(to: beginning)
            p.addLine(to: CGPoint(x: 12, y: 32))
        }
        .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
    }
}

struct CircleView: View {
    @State private var viewID = UUID() // Use a UUID as an identifier

    @State public var progress: CGFloat
    var progreso: CGFloat
    
    var size: CGFloat
    var isArrow: Bool
    
    // For close the circle and arrows
    public var fullCircle: CGFloat { return 300 * -size / 2 }
    var circleSize: CGFloat = 10.0
        
    private var color: [Color] {
        get {
            [Color.lightRed,
            Color.darkRed]
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                if progress < 0.98 {
                    // Background Circle (what has not been completed)
                    Circle()
                        .scale(size)
                        .stroke(color[1], lineWidth: circleSize)
                    
                    // Activity (what has been completed)
                    Circle()
                        .scale(size)
                        .trim(from: 0, to: progress)
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [color[0]]),
                                center: .center,
                                startAngle: .degrees(0.0),
                                endAngle: .init(degrees: 360.0)
                            ),
                            style: StrokeStyle(lineWidth: circleSize, lineCap: .round))
                        .rotationEffect(.degrees(-90.0))
                    
                    // For the overlapping
                    Circle()
                        .frame(width: circleSize, height: circleSize)
                        .foregroundColor(color[0])
                        .offset(y: -150 * size)
                    
                } else {
                    // Activity (what has been completed)
                    Circle()
                        .scale(size)
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [color[0]]),
                                center: .center,
                                startAngle: .degrees(0.0),
                                endAngle: .init(degrees: 360.0)
                            ),
                            style: StrokeStyle(lineWidth: circleSize, lineCap: .round))
                        .rotationEffect(.degrees((360 * Double(progress)) - 90))
                    
                    // Let the circle overlap
                    Circle()
                        .frame(width: circleSize, height: circleSize)
                        .offset(y: -150 * size)
                        .foregroundColor(color[0])
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: circleSize / 4, y: 0)
                        .rotationEffect(.degrees(360 * Double(progress)))
                }
                
                // Arrow
                if isArrow {
                    Arrow()
                        .foregroundColor(.black)
                        .frame(width: 25, height: 40)
                        .rotationEffect(.degrees(0))
                        .offset(y: -150 * size)
                }
            }
            .frame(width: 300, height: 300)
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    // Adjust this value to control the initial animation
                    self.progress = progreso
                }
            }
        }
    }
}

#Preview {
    CircleView(progress: 0, progreso: 0.8, size: 0.70, isArrow: true, circleSize: 60)
}
