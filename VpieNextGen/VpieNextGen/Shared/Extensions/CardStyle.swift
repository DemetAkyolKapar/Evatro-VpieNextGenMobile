//
//  CardStyle.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 19.11.2025.
//

import Foundation
import SwiftUI

struct CardStyle: ViewModifier {
    var padding: CGFloat
    var cornerRadius: CGFloat
    var strokeColor: Color
    var strokeWidth: CGFloat
    var shadowColor: Color
    var shadowRadius: CGFloat
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor.opacity(0.2),
                            radius: shadowRadius, y: 0.3)
                
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(strokeColor.opacity(0.12), lineWidth: strokeWidth * 0.7)
                    )
            )
    }
}


extension View {
    func cardStyle(
        padding: CGFloat = AppPadding.large,
        cornerRadius: CGFloat = AppCornerRadius.card,
        strokeColor: Color = .vpieGrayWithDarkMode.opacity(0.3),
        strokeWidth: CGFloat = AppLineWidth.thin,
        shadowColor: Color = .shadowColor,
        shadowRadius: CGFloat = 0.7,
        backgroundColor: Color = .cardBackground
    ) -> some View {
        self.modifier(
            CardStyle(
                padding: padding,
                cornerRadius: cornerRadius,
                strokeColor: strokeColor,
                strokeWidth: strokeWidth,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                backgroundColor: backgroundColor
            )
        )
    }
}
