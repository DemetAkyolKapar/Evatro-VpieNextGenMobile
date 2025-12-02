//
//  FixedGridLayout.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 1.12.2025.
//

import SwiftUI

struct LayoutItem: Identifiable, Codable {
    var id = UUID()
    let text: String
    let layout: String
}

struct LayoutPosition {
    let row: Int
    let col: Int
    let span: Int
}

func parseLayout(_ layout: String) -> LayoutPosition {
    if !layout.contains("|") {
        let row = Int(layout) ?? 1
        return LayoutPosition(row: row, col: 1, span: 2)
    }
    
    let parts = layout.split(separator: "|")
    let row = Int(parts[0]) ?? 1
    let col = Int(parts[1]) ?? 1
    
    return LayoutPosition(row: row, col: col, span: 1)
}

struct FixedGridLayout: View {
    let items: [LayoutItem]

    private let grid = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LazyVGrid(columns: grid, spacing: AppSpacing.thin) {
            ForEach(1..<6, id: \.self) { row in
                
                if let item1 = items.first(where: { parseLayout($0.layout).row == row && parseLayout($0.layout).col == 1 }) {
                    let pos = parseLayout(item1.layout)
                    Text(item1.text)
                        .itemStyle()
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .gridCellColumns(pos.span)
                    
                    if pos.span == 2 {
                        Color.clear.frame(height: 0)
                    } else {
                        if let item2 = items.first(where: { parseLayout($0.layout).row == row && parseLayout($0.layout).col == 2 }) {
                            Text(item2.text)
                                .itemStyle()
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)

                        } else {
                            Color.clear.frame(height: 1)
                        }
                    }
                } else {
                    Color.clear.frame(height: 1)
                    if let item2 = items.first(where: { parseLayout($0.layout).row == row && parseLayout($0.layout).col == 2 }) {
                        Text(item2.text)
                            .itemStyle()
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Color.clear.frame(height: 1)
                    }
                }
            }
        }
    }
}
