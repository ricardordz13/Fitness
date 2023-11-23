//
//  Extensions.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 15/11/23.
//

import Foundation
import SwiftUI

extension Color {    
    // Ring Background
    public static var darkRed: Color {
        return Color(decimalRed: 38, green: 2, blue: 6)
    }
    
    // Ring Progress
    public static var lightRed: Color {
        return Color(decimalRed: 249, green: 18, blue: 80)

    }
    
    // Red text on Activity Details
    public static var textRed: Color {
        return Color(decimalRed: 254, green: 14, blue: 83)
    }
    
    // Red on the Graph
    public static var graphRed: Color {
        return Color(decimalRed: 237, green: 24, blue: 82)
    }
    
    // First Gray on the Graph
    public static var initialGray: Color {
        return Color(decimalRed: 70, green: 70, blue: 70)
    }
    
    // Second Gray on the Graph
    public static var secondGray: Color {
        return Color(decimalRed: 51, green: 51, blue: 51)
    }
    
    // Legend Text (Graph)
    public static var legendGray: Color {
        return Color(decimalRed: 171, green: 181, blue: 191)
    }
    
    // Gray for the Footer
    public static var footerGray: Color {
        return Color(decimalRed: 180, green: 187, blue: 195)
    }
    
    // Spacer on Footer
    public static var spacerGray: Color {
        return Color(decimalRed: 29, green: 29, blue: 29)
    }
    
    // Spacer on Footer
    public static var barGreen: Color {
        return Color(decimalRed: 158, green: 215, blue: 48)
    }
    
    // TabBar
    public static var grayTabBar: Color {
        return Color(decimalRed: 38, green: 41, blue: 34)
    }
    
    // Rectangle on Summary View
    public static var grayRectangle: Color {
        return Color(decimalRed: 28, green: 28, blue: 30)
    }
            
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
}

extension Date {
    static func monday() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
    static func dateFormatter(string: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = string
        return formatter
    }
}

struct Constants {
    static let maxColumns: Int = 96 // maximo de columnas
    static let widthColumn: CGFloat = 2.6 // altura de las columnas
    static let spaceColumn: CGFloat = 1 // espaciado entre columnas
}
