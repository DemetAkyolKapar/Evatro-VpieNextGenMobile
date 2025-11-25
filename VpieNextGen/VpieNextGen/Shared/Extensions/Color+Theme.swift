//
//  Color+Theme.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 13.11.2025.
//

import SwiftUI

extension Color {
    static let shadowColor = Color("shadowColor")
    
}
extension Color {
    init(hex: String, opacity: Double = 1.0) {
        var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255

        self.init(red: r, green: g, blue: b, opacity: opacity)
    }
}
