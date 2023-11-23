//
//  NavBarView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 18/11/23.
//

import SwiftUI

struct NavBarView: View {
    @State private var selectedCircleIndex: Int = 0 // Set the initial selected index
    @State private var healthStore = HealthStore()

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 10) {
                ForEach(0..<7) { item in
                    VStack(spacing: 5) {
                        Text("\(ActivityData.weekdays[item].firstLetter)")
                            .font(Font.system(size: 10, weight: .medium, design: .default))
                            .foregroundColor(item == selectedCircleIndex ? Color.white : Color.legendGray)
                            .background(
                                Circle()
                                    .fill(Color.lightRed)
                                    .frame(width: 20, height: 20)
                                    .opacity(item == selectedCircleIndex ? 1 : 0)
                            )
                            .onTapGesture {
                                // Only allow selection if the date is on or before the current day
                                if item + 1 <= Calendar.current.component(.weekday, from: Date()) {
                                    selectedCircleIndex = item
                                }
                            }

                        // Use the steps data from thisWeekSteps dictionary
                        if let steps = healthStore.thisWeekSteps[item + 1] {
                            CircleView(progress: 0, progreso: CGFloat(steps) / CGFloat(3500), size: 0.1, isArrow: false, circleSize: 10)
                                .frame(width: 45, height: 50)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
        }
        .task {
            // Find the index of the current day
            selectedCircleIndex = Calendar.current.component(.weekday, from: Date()) - 1

            healthStore.requestAuthorization()
            do {
                healthStore.fetchAllDatas()
            }
        }
    }
}

#Preview {
    NavBarView()
}
