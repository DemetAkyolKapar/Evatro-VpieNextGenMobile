//
//  ExpandableListCard.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 27.11.2025.
//

import SwiftUI

public struct ExpandableListItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let value: String?
    public init(title: String, value: String? = nil) {
        self.title = title
        self.value = value
    }
}

public struct ExpandableListCard: View {
    public var title: String
    public var subtitle: String? = nil
    public var items: [ExpandableListItem]
    public var horizontalPadding: CGFloat
    @State private var isExpanded: Bool
 
    public init(title: String,
                subtitle: String? = nil,
                isInitiallyExpanded: Bool = false,
                items: [ExpandableListItem],
                horizontalPadding: CGFloat? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.items = items
        self.horizontalPadding = horizontalPadding ?? AppPadding.small
        self._isExpanded = State(initialValue: isInitiallyExpanded)
    }

    public var body: some View {
        VStack(spacing: 0) {
            header
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        row(item)
                        if index < items.count - 1 {
                            Line()
                                .stroke(.vpieGrayWithDarkMode.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [2]))
                                .frame(height: 0.5)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
                .padding(.top, 6)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: isExpanded)
        .cardStyle(padding: AppPadding.small, backgroundColor: .cardBackground)
        .padding(.horizontal, horizontalPadding)
    }

    private var header: some View {
        Button(action: { isExpanded.toggle() }) {
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: FontSize.standard, weight: .semibold))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .foregroundColor(.appBlack)
                        .lineLimit(1)
                    if let subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.system(size: FontSize.thin, weight: .regular))
                            .dynamicTypeSize(.xSmall ... .accessibility5)
                            .foregroundColor(.vpieGrayWithDarkMode)
                            .lineLimit(1)
                    }
                }
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.system(size: FontSize.standard, weight: .semibold))
                    .dynamicTypeSize(.xSmall ... .accessibility5)
                    .foregroundColor(.vpieGrayWithDarkMode)
                    .frame(width: 28, height: 28)
                    .background(Circle().fill(Color.vpieGrayWithDarkMode.opacity(0.12)))
                    .accessibilityHidden(true)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(.isButton)
    }

    @ViewBuilder private func row(_ item: ExpandableListItem) -> some View {
        HStack(alignment: .center, spacing: AppSpacing.standard) {
            Text(item.title)
                .font(.system(size: FontSize.thin, weight: .regular))
                .foregroundColor(.appBlack)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
            
            if let value = item.value, !value.isEmpty {
                Text(value)
                    .font(.system(size: FontSize.standard))
                    .foregroundColor(Color.vpieGray)
                    .dynamicTypeSize(.xSmall ... .accessibility5)
                    .lineLimit(1)

            }
        }.padding(.trailing, 5)

    }
}

#Preview {
        ExpandableListCard(
            title: "Inventory items",
            subtitle: "Required inventory for today's jobs",
            isInitiallyExpanded: true,
            items: [
                ExpandableListItem(title: "Meter/Radio,5/8,REMPT", value: "12"),
                ExpandableListItem(title: "Radio,8\" ,REMPT", value: "5"),
                ExpandableListItem(title: "Meter,5\",REMPT", value: "7"),
            ]
        )
}
