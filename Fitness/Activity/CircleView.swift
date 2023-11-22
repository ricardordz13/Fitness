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
    var progress: CGFloat
    
    // For close the circle and arrows
    private var fullCircle: CGFloat { return 300 * -0.82 / 2 }
    private let circleSize: CGFloat = 60.0
        
    private var color: [Color] {
        get {
            [Color.lightRed,
            Color.darkRed]
        }
    }
    
    var body: some View {
        ZStack {
            if self.progress < 0.98 {
                // Background Circle (what has not been completed)
                Circle()
                    .scale(0.82)
                    .stroke(self.color[1], lineWidth: self.circleSize)
                
                // Activity (what has been completed)
                Circle()
                    .scale(0.82)
                    .trim(from: 0, to: self.progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [self.color[0]]),
                            center: .center,
                            startAngle: .degrees(0.0),
                            endAngle: .init(degrees: 360.0)
                        ),
                        style: StrokeStyle(lineWidth: self.circleSize, lineCap: .round))
                    .rotationEffect(.degrees(-90.0))
                
                // For the overlapping
                Circle()
                    .frame(width: self.circleSize, height: self.circleSize)
                    .foregroundColor(self.color[0])
                    .offset(y: self.fullCircle)
                
            } else {
                // Activity (what has been completed)
                Circle()
                    .scale(0.82)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [self.color[0]]),
                            center: .center,
                            startAngle: .degrees(0.0),
                            endAngle: .init(degrees: 360.0)
                        ),
                        style: StrokeStyle(lineWidth: self.circleSize, lineCap: .round))
                    .rotationEffect(.degrees((360 * Double(self.progress)) - 90))
                
                // Let the circle overlap
                Circle()
                    .frame(width: self.circleSize, height: self.circleSize)
                    .offset(y: self.fullCircle)
                    .foregroundColor(self.color[0])
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: self.circleSize / 4, y: 0)
                    .rotationEffect(.degrees(360 * Double(self.progress)))
            }
            
            // Arrow
            Arrow()
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(0))
                .offset(x: 5, y: self.fullCircle)
        }
        .frame(width: 300, height: 300)
    }
}
 
#Preview {
    CircleView(progress: 1.5)
}
