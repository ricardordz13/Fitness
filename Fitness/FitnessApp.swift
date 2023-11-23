//
//  FitnessApp.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 14/11/23.
//

import SwiftUI

@main
struct FitnessApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SummaryView2(
                    progress: 27,
                    goal: 150
                    //pasos: 1209,
                    //distancia: 0.77
                )
                    .tabItem {
                        Image(systemName: "circle.circle")
                        Text("Summary")
                    }
                ContentView()
                    .tabItem {
                        Image(systemName: "figure.run.circle.fill")
                        Text("Fitness+")
                    }
                ContentView()
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("Sharing")
                    }
            }.accentColor(Color.barGreen)
                .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}
