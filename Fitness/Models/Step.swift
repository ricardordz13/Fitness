//
//  Step.swift
//  Fitness
//
//  Created by Ricardo Jorge Rodriguez Trevino on 21/11/23.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
