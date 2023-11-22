//
//  SummaryView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 14/11/23.
//

import SwiftUI

struct ActivityView: View {
    @State private var progress: CGFloat = 0
    
    //var step: Step

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    
                    // Ring
                    CircleView(progress: progress)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                // Update the progress value to see the animation
                                self.progress = 0.2
                            }
                        }
                    
                    // Here the charts
                    GraphView(
                        progress: 48,
                        goal: 150,
                        data: ActivityData.moveChartData,
                        total: 767,
                        maximo: 22
                    )
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) {}
                    }
                    // Here the steps, distance and flights climbed
                    
                }
                .padding()
                .navigationBarTitle("Date")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button { } label: { Image(systemName: "calendar") }
                            Button { } label: { Image(systemName: "square.and.arrow.up") }
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    ActivityView()
}
