//
//  AdaptiveStack.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 11.11.2025.
//

import SwiftUI

struct AdaptiveStack<Content: View>: View {
    let isHorizontal: Bool
    var spacing: CGFloat = 16
    @ViewBuilder let content: () -> Content

    var body: some View {
        Group {
            if isHorizontal {
                HStack(spacing: spacing, content: content)
            } else {
                VStack(spacing: spacing, content: content)
            }
        }
    }
}

