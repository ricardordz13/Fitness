//
//  SummaryView.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 14/11/23.
//

import SwiftUI

struct SummaryView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HStack {
                    
                }
                
                ScrollView {
                    NavigationLink("Summary") {
                        ActivityView()
                    }
                }
            }
        }.accentColor(Color.barGreen) 
    }
}
 
#Preview {
    SummaryView()
}


