//
//  ActivityViewModel.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 16/11/23.
//

import Foundation

struct ActivityData {
    
    static let weekdays: [(firstLetter: String, movePercentage: Double)] = [
        (firstLetter: "S", movePercentage: 1.5),
        (firstLetter: "M", movePercentage: 0.5),
        (firstLetter: "T", movePercentage: 1.2),
        (firstLetter: "W", movePercentage: 1.9),
        (firstLetter: "T", movePercentage: 0.1),
        (firstLetter: "F", movePercentage: 0.3),
        (firstLetter: "S", movePercentage: 0.8)
    ]
        
    static let moveChartData: [Int: Double] = [
        20: Double.random(in: 0...60),
        21: Double.random(in: 0...60),
        22: Double.random(in: 0...60),
        23: Double.random(in: 0...60),
        50: Double.random(in: 0...60),
        51: Double.random(in: 0...60),
        52: Double.random(in: 0...60),
        53: Double.random(in: 0...60),
        54: Double.random(in: 0...60),
        55: Double.random(in: 0...60),
        56: Double.random(in: 0...60),
        57: Double.random(in: 0...60),
        58: Double.random(in: 0...60),
        59: Double.random(in: 0...60),
        60: Double.random(in: 0...60),
        61: Double.random(in: 0...60),
        62: Double.random(in: 0...60),
        63: Double.random(in: 0...60),
        64: Double.random(in: 0...60),
        65: Double.random(in: 0...60),
        80: Double.random(in: 0...60),
        81: Double.random(in: 0...60),
        82: Double.random(in: 0...60),
        83: Double.random(in: 0...60),
        84: Double.random(in: 0...60),
        85: Double.random(in: 0...60)
    ]
    
    static let steps: String = "5 588"
    static let distance: String = "4,5"
    static let flightsClimbed: String = "4"
    
}
