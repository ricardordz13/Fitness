//
//  SummaryView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 14/11/23.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        ScrollView {
            NavigationLink("Summary") {
                ActivityView()
            }
        }
    }
}

struct SummaryView2: View {

    @State private var healthStore = HealthStore()
    
    private var steps: [Step] {
        healthStore.steps.sorted { lhs, rhs in
            lhs.date > rhs.date
        }
    }
    
    var progress: Int = 0
    var goal: Int
    //var pasos: Int
    //var distancia: Double
    
    // Header
    let columns = [
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15)
    ]
    
    // Nav Bar
    @State private var barHidden = true
        
    var body: some View {

        let distancia = 0.415 * 1.75 * CGFloat(healthStore.stepCountToday) / 1000
        let progreso = CGFloat(healthStore.caloriesBurnedToday) / CGFloat(goal)
        
        NavigationStack {
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
            
                    VStack {
                        
                        // Header
                        VStack(alignment: .leading){
                            LazyVGrid(columns: columns, alignment: .leading, spacing: 1) {
                                VStack(alignment: .leading) {
                                    Text("\(formattedDate)")
                                        .textCase(.uppercase)
                                        .font(Font.system(size: 13, weight: .bold))
                                        .foregroundColor(Color.legendGray)
                                    Text("Summary")
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(Color.white)
                                }
                                VStack(alignment: .leading){
                                    Image("ivan_p")
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 50, height: 50)
                                        .padding(.leading, 140)
                                }
                            }
                        }.padding(.horizontal)
                            .padding(.top, 80)

                        // Activity
                        VStack(alignment: .leading) {
                                
                            Text("Activity")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.white)
                                .padding()
                                .padding(.bottom, -25)
                                
                            NavigationLink(destination: ActivityView()) {
                                    
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Move")
                                            .font(Font.system(size: 15, weight: .regular))
                                            .kerning(0.05)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 4)
                                        (
                                            Text("\(healthStore.caloriesBurnedToday)/\(goal)")
                                                .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                                                .foregroundColor(Color.textRed)
                                            + Text("KCAL")
                                                .font(Font.system(size: 14, weight: .semibold, design: .rounded))
                                                .foregroundColor(Color.textRed)
                                        )
                                        .padding(.top, -15)
                                        .padding(.bottom, 5)
                                            
                                        Text("Steps")
                                            .font(Font.system(size: 15, weight: .regular))
                                            .kerning(0.05)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 4)
                                        (
                                            // Text("\(pasos)")
                                            Text("\(healthStore.stepCountToday)")
                                                .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                                                .foregroundColor(Color.legendGray)
                                        )
                                        .padding(.top, -15)
                                        .padding(.bottom, 5)
                                            
                                        Text("Distance")
                                            .font(Font.system(size: 15, weight: .regular))
                                            .kerning(0.05)
                                            .foregroundColor(Color.white)
                                            .padding(.bottom, 4)
                                        (
                                            Text("\(distancia, specifier: "%.2f")")
                                                .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                                                .foregroundColor(Color.legendGray)
                                            + Text("KM")
                                                .font(Font.system(size: 14, weight: .semibold, design: .rounded))
                                                .foregroundColor(Color.legendGray)
                                        )
                                        .padding(.top, -15)
                                        .padding(.bottom, 5)
                                            
                                    }.padding()
                                        
                                    VStack(alignment: .leading) {
                                        CircleView(progress: 0, progreso: progreso, size: 0.35, isArrow: false, circleSize: 30)
                                            .padding(.bottom, -60)
                                            .padding(.top, -60)
                                            .padding(.leading, -18)
                                            .padding(.trailing, -18)
                                            .onAppear {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    
                                                }
                                            }
                                    }.padding(.trailing, -45)
                                        
                                        
                                }.background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.grayRectangle)
                                )
                                .padding()
                            }
                        }
                    

                        // Trainer Tips
                        VStack(alignment: .leading) {
                            Text("Trainer Tips")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.white)
                                .padding()
                                .padding(.bottom, -25)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Image("Ivan")
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 70, height: 70)
                                        .padding(.leading, 3)
                                        .padding(.bottom, 32)
                                }
                                VStack(alignment: .leading) {
                                    Text("A motivation tip to help you run or walk for longer")
                                        .font(Font.system(size: 16))
                                        .bold()
                                        .foregroundColor(Color.white)
                                    
                                    Text("with Fitness+ Trainer Ivan")
                                        .font(Font.system(size: 12, weight: .regular))
                                        .foregroundColor(Color.legendGray)
                                        .padding(.top, -3)
                                    
                                    Divider()
                                        .background(Color.spacerGray)
                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 8, trailing: 0))
                                    
                                    Text("Watch this Week's Tip")
                                        .font(Font.system(size: 15, weight: .regular))
                                        .foregroundColor(Color.barGreen)
                                        .padding(.vertical, -8)
                                    
                                }.padding()
                                    .padding(.leading, -22)
                                
                            }.background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.grayRectangle)
                            )
                            .padding()
                        }
                        
                        // Trends
                        VStack(alignment: .leading) {
                            Text("Trends")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.white)
                                .padding()
                                .padding(.bottom, -25)
                            
                            VStack {
                                VStack(alignment: .leading) {
                                    GifView("walking2")
                                        .frame(width: 150, height: 129)
                                        .padding(.leading, 81)
                                        .padding(.top, -15)
                                        .padding(.bottom, -15)
                                    
                                    Text("Closing your rings every day is a great way to stay active. Trend arrows help you stay motivated by showing even more details.")
                                        .font(Font.system(size: 17))
                                        .foregroundColor(Color.white)
                                    
                                    Text("Get Started")
                                        .font(Font.system(size: 17))
                                        .foregroundColor(Color.barGreen)
                                        .padding(.top, -3)
                                    
                                }.padding()
                            }.background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.grayRectangle)
                            )
                            .padding()
                        }
                        
                        // Awards
                        VStack(alignment: .leading) {
                            Text("Awards")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.white)
                                .padding()
                                .padding(.bottom, -25)
                            
                            VStack {
                                HStack(spacing: 0) {
                                    VStack {
                                        Image("patricio")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 120, height: 120)
                                        
                                        Text("November Challenge")
                                            .font(Font.system(size: 10))
                                            .foregroundColor(Color.white)
                                            .padding()
                                            .padding(.top, -30)
                                        
                                        Text("9 of 4 days")
                                            .font(Font.system(size: 10))
                                            .foregroundColor(Color.legendGray)
                                            .padding()
                                            .padding(.top, -40)
                                        
                                        Spacer()
                                    }
                                    
                                    VStack {
                                        Image("patito")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 120, height: 120)
                                        
                                        Text("New Move Record")
                                            .font(Font.system(size: 10))
                                            .foregroundColor(Color.white)
                                            .padding()
                                            .padding(.top, -30)
                                        
                                        Text("223 kilocalories")
                                            .font(Font.system(size: 10))
                                            .foregroundColor(Color.legendGray)
                                            .padding()
                                            .padding(.top, -40)
                                        
                                        Spacer()
                                    }
                                    
                                    VStack {
                                        Image("patos")
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 120, height: 120)
                                        
                                        Text("New Move Goal")
                                            .font(Font.system(size: 10))
                                            .foregroundColor(Color.white)
                                            .padding()
                                            .padding(.top, -30)
                                        
                                        Text("150 kilocalories")
                                            .font(Font.system(size: 10))
                                            .foregroundColor(Color.legendGray)
                                            .padding()
                                            .padding(.top, -40)
                                        
                                        Spacer()
                                        
                                        // Giulia Cegghetini
                                    }
                                }
                                
                            }.background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.grayRectangle)
                            )
                            .padding()
                        }.padding(.bottom, 100)
                        Spacer()
                        Spacer()
                        Spacer()
                        
                    
                    } // Después de esto empieza lo nuevo
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewOffsetKey.self,
                            value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onPreferenceChange(ViewOffsetKey.self) {
                        if !barHidden && $0 < 50 {
                            barHidden = true
                        } else if barHidden && $0 > 50{
                            barHidden = false
                        }
                    }
                    
                }.coordinateSpace(name: "scroll")
                    .navigationBarTitle("Summary", displayMode: .inline)
                    .navigationBarHidden(barHidden)
                    .toolbarColorScheme(.dark, for: .navigationBar)
            }.accentColor(Color.barGreen)
                .animation(.default, value: barHidden)
                        .edgesIgnoringSafeArea(.all)
        }.task {
            healthStore.requestAuthorization()
            do {
                healthStore.fetchAllDatas()
            }
        }
        
    }
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM"
        return dateFormatter.string(from: Date())
    }
}

// For the Nav Bar
struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    SummaryView2(
        progress: 27,
        goal: 150
        //pasos: 1209,
        //distancia: 0.77
    )
}


