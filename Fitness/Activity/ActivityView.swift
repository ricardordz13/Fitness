//
//  SummaryView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 14/11/23.
//

import SwiftUI

struct ActivityView: View {
    @State private var progress: CGFloat = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var healthStore = HealthStore()
    
    private var steps: [Step] {
        healthStore.steps.sorted { lhs, rhs in
            lhs.date > rhs.date
        }
    }

    var body: some View {
        
        var distancia = 0.415 * 1.75 * CGFloat(healthStore.stepCountToday) / 1000
        var progreso = CGFloat(healthStore.caloriesBurnedToday) / CGFloat(150)
        
        GeometryReader { geometry in
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                    VStack {
                       // Navigation Bar
                        NavBarView()
                        
                        ScrollView {
                        // Ring
                            CircleView(progress: progress, progreso: progreso, size: 0.70, isArrow: true, circleSize: 50)
                            .padding(.bottom, -18)
                            .accessibility(label: Text("Moving: \(progreso*100 , specifier: "%.2f") percent"))

                        // Charts
                        GraphView(
                            progress: healthStore.caloriesBurnedToday,
                            goal: 150,
                            data: ActivityData.moveChartData,
                            total: healthStore.stepCountToday / 2,
                            maximo: 22
                        )
                        .padding(.bottom)
                        
                        // Steps, distance and flights climbed
                        FooterView(
                            pasos: healthStore.stepCountToday,
                            distancia: distancia,
                            subidas: healthStore.stepCountToday / 1000
                        )
                        
                    }
                    .padding(.horizontal)
                    .navigationBarTitle(Text("\(formattedDate)"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Button { } label: { Image(systemName: "calendar") }
                                Button { } label: { Image(systemName: "square.and.arrow.up") }
                            }
                        }
                    }.accentColor(Color.barGreen)
                }
            }
        }.task {
            healthStore.requestAuthorization()
            do {
                healthStore.fetchAllDatas()
            }
        }.onAppear() {
            healthStore.fetchAllDatas()
        }
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM yyyy"
        return dateFormatter.string(from: Date())
    }
    
}

#Preview {
    ActivityView()
}
