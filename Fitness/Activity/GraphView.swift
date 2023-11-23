//
//  GraphView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 16/11/23.
//

import SwiftUI

struct GraphView: View {
    var progress: Int
    var goal: Int
    var data: [Int: Double]
    var total: Int
    var maximo: Int
    
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Move")
                        .font(Font.system(size: 16, weight: .regular))
                        .kerning(0.05)
                        .foregroundColor(Color.white)
                        .padding(.bottom, 4)
                    (
                        Text("\(progress)/\(goal)")
                            .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.textRed)
                        + Text("KCAL")
                            .font(Font.system(size: 21, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.textRed)
                    )
                    .padding(.top, -15)
                }
                .padding(.bottom, 2)
                self.createGrid()
                self.legend()
                Text("TOTAL \(total) KCAL")
                    .font(Font.system(size: 11, weight: .regular, design: .default))
                    .foregroundColor(Color.textRed)
            }
            
        }
        
    }
    
    // Function to create the grid on which the graph will be placed
    func createGrid() -> some View {
        let maxColumnIndex = Constants.maxColumns - 1
        
        return ZStack(alignment: .bottomLeading) {
            VStack(alignment: .center, spacing: 20) {
                // Line 1
                HStack(alignment: .center, spacing: Constants.widthColumn) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(Color.initialGray)
                            .frame(width: 1, height: 1)
                    }
                }
                // Line 2
                HStack(alignment: .center, spacing: Constants.widthColumn) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(Color.secondGray)
                            .frame(width: 1, height: 1)
                    }
                }
                .overlay(
                    Text("\(maximo) KCAL")
                        .font(Font.system(size: 10, weight: .medium, design: .default))
                        .foregroundColor(Color.legendGray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .offset(y: -14) // Adjust the offset as needed
                )
                // Line 3
                HStack(alignment: .center, spacing: Constants.widthColumn) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(Color.secondGray)
                            .frame(width: 1, height: 1)
                    }
                }
                // Line 4
                HStack(alignment: .top, spacing: Constants.spaceColumn) {
                    ForEach(0..<maxColumnIndex) { i in
                        Rectangle()
                            .fill(Color.graphRed)
                            .frame(width: Constants.widthColumn, height: Constants.widthColumn)
                            .cornerRadius(Constants.widthColumn / 2)
                    }
                }
            }
            
            HStack(alignment: .bottom, spacing: Constants.spaceColumn) {
                ForEach(0..<maxColumnIndex) { i in
                    BarChart(height: self.data[i] ?? Double(0))
                }
            }
            .drawingGroup()
        }
    }
    
    // Function to add the Legend to the Chart
    func legend() -> some View{
        HStack(alignment: .center) {
            self.legendItem("00:00")
            Spacer()
            self.legendItem("06:00")
            Spacer()
            self.legendItem("12:00")
            Spacer()
            self.legendItem("18:00")
        }
    }

    func legendItem(_ time: String) -> some View {
        Text(time)
            .font(Font.system(size: 10, weight: .medium, design: .default))
            .foregroundColor(Color.legendGray)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

struct BarShape: Shape {
    
    var maxHeight: Double
    var currentHeight: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius = Constants.widthColumn / 2
        path.addRoundedRect(in: CGRect(x: 0, y: CGFloat(maxHeight - currentHeight), width: Constants.widthColumn, height: CGFloat(currentHeight)), cornerSize: CGSize(width: cornerRadius, height: cornerRadius))
        return path
    }
    
    var animatableData: Double {
        get { return currentHeight }
        set { currentHeight = newValue }
    }
    
}

struct BarChart: View {
    
    @State var currentHeight: Double = 0
    var height: Double
    
    var animation: Animation {
        Animation.easeInOut(duration: 0.2)
    }
    
    var body: some View {
        BarShape(maxHeight: height, currentHeight: currentHeight)
            .fill(Color.textRed)
            .frame(width: Constants.widthColumn, height: CGFloat(self.height))
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(self.animation) {
                        self.currentHeight = height
                    }
                }
            }
    }
}

#Preview {
    GraphView(
        progress: 76,
        goal: 150,
        data: ActivityData.moveChartData,
        total: 767,
        maximo: 22
    )
}
