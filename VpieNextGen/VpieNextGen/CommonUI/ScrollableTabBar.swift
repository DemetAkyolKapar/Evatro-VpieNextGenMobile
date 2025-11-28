//
//  ScrollableTabBar.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 25.11.2025.
//

import SwiftUI

struct TabItem: Identifiable, Hashable, Equatable {
    let id = UUID()
    let title: String
    let systemImage: String?
    let view: AnyView

    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.systemImage == rhs.systemImage
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(systemImage)
    }
}

struct ResponsiveTabBar: View {
    let tabs: [TabItem]
    @Binding var selectedIndex: Int
    @Namespace private var underlineNS

    var body: some View {
        HStack(spacing: 16) {
            ForEach(Array(tabs.enumerated()), id: \.1.id) { index, tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedIndex = index
                    }
                } label: {
                    VStack(spacing: AppSpacing.tight) {
                        HStack(spacing: AppSpacing.tight) {
                            if let icon = tab.systemImage {
                                Image(systemName: icon)
                                    .font(.system(size: FontSize.standard))
                            }
                            Text(tab.title)
                                .font( .scalable(size: 16))
                                .fontWeight(.semibold)
                                .dynamicTypeSize(.xSmall ... .accessibility5)
                                .lineLimit(1)
                        }
                        .foregroundColor(selectedIndex == index ? .appBlack : .vpieGray)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(
                            ZStack {
                                
                                if selectedIndex == index {
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(.appBlack)
                                        .frame(height: 2)
                                        .matchedGeometryEffect(id: "underline", in: underlineNS)
                                        .offset(y: 20)
                                } else {
                                    Color.clear.frame(height: 2)
                                }
                            }
                        )
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 35,alignment: .leading)
    }
}

