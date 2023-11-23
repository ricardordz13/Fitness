//
//  FooterView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 17/11/23.
//

import SwiftUI

struct FooterView: View {
    var pasos: Int
    var distancia: Double
    var subidas: Int
    
    @State private var healthStore = HealthStore()
    
    let columns = [
        GridItem(.flexible(), spacing: -15),
        GridItem(.flexible(), spacing: -15)
    ]
    
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                LazyVGrid(columns: columns, alignment: .leading, spacing: 1) {
                        VStack(alignment: .leading) {
                            Text("Steps")
                                .font(Font.system(size: 16, weight: .regular))
                                .kerning(0.05)
                                .foregroundColor(Color.white)
                                .padding(.bottom, -12)
                            Text("\(pasos)")
                                .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                                .kerning(0.25)
                                .foregroundColor(Color.footerGray)
                        }
                        VStack(alignment: .leading) {
                            Text("Distance")
                                .font(Font.system(size: 16, weight: .regular))
                                .kerning(0.05)
                                .foregroundColor(Color.white)
                                .padding(.bottom, -12)
                            (
                                Text("\(distancia, specifier: "%.2f")")
                                    .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                                    .kerning(0.25)
                                    .foregroundColor(Color.footerGray)
                                + Text("KM")
                                    .font(Font.system(size: 21, weight: .semibold, design: .rounded))
                                    .kerning(0.25)
                                    .foregroundColor(Color.footerGray)
                            )
                        }
                        Spacer()
                    
                }
                Divider()
                    .background(Color.spacerGray)
                    .padding(EdgeInsets(top: -8, leading: 0, bottom: 6, trailing: 0))
                Text("Flights Climbed")
                    .font(Font.system(size: 16, weight: .regular))
                    .kerning(0.05)
                    .foregroundColor(Color.white)
                    .padding(.bottom, -12)
                Text("\(subidas)")
                    .font(Font.system(size: 28, weight: .semibold, design: .rounded))
                    .kerning(0.25)
                    .foregroundColor(Color.footerGray)
            }
        }
        
    }
}

#Preview {
    FooterView(
        pasos: 2366,
        distancia: 1.69,
        subidas: 4
    )
}
