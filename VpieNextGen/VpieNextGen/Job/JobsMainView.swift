//
//  JobsMainView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 13.11.2025.
//

import SwiftUI

struct JobsMainView: View {
    @State private var selectedIndex = 0
    @State private var isWeek: Bool = false
    
    private var tabs: [TabItem] = [
        TabItem(title: "Scheduled", systemImage: "calendar.badge.clock", view: AnyView(JobListView(vm: JobListViewModel(service: VpieJobService())))),
        
        TabItem(title: "Any Day", systemImage: "list.bullet", view: AnyView(JobListView(vm: JobListViewModel(service: VpieJobService())))),
        
        TabItem(title: "Map", systemImage: "map", view: AnyView(SettingsView())),
    ]
    
    var body: some View {
        let horizontalPadding: CGFloat = AppPadding.medium
        let spacing: CGFloat = AppSpacing.tight
        let screenWidth = UIScreen.main.bounds.width
        let available = screenWidth - (horizontalPadding * 2) - (spacing * 3)
        let cardWidth = max(60, available / 4)
        let ratio: CGFloat = 140.0 / 260.0
        let rowHeight: CGFloat = cardWidth * ratio
        let columns = Array(repeating: GridItem(.fixed(cardWidth), spacing: spacing, alignment: .top), count: 4)
        
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            VStack(alignment: .leading, spacing: AppSpacing.standard) {
                LazyVGrid(columns: columns, alignment: .center, spacing: spacing) {
                    MetricCard(
                        width: cardWidth,
                        title: "Completed",
                        value: "7",
                        iconName: "list.bullet.rectangle",
                        iconColor: Color(hex: "#10B981"),
                        gradient: [Color(hex: "#D1FAE5"), Color(hex: "#6EE7B7")]
                    )
                    MetricCard(
                        width: cardWidth,
                        title: "To be completed",
                        value: "17",
                        iconName: "clock",
                        iconColor: Color(hex: "#7C3AED"),
                        gradient: [Color(hex: "#EDE9FE"), Color(hex: "#D8B4FE")]
                    )
                    MetricCard(
                        width: cardWidth,
                        title: "Needs sync",
                        value: "60",
                        iconName: "exclamationmark.arrow.triangle.2.circlepath",
                        iconColor: Color(hex: "#D97706"),
                        gradient: [Color(hex: "#FEF3C7"), Color(hex: "#FDE68A")]
                    )
                }
                .padding(.horizontal, horizontalPadding)
                .frame(height: rowHeight)
                .overlay(alignment: .trailing) {
                    
                    // Far right card: same size and vertical alignment as MetricCard
                    let isCompact = cardWidth < 110
                    let scale = max(0.6, min(1.4, cardWidth / 260.0))
                    let titleFont: CGFloat = (FontSize.large) * scale
                    let iconScale = cardWidth / 200.0
                    let baseIcon: CGFloat = isCompact ? 30 : 40
                    let iconSize: CGFloat = min(max(baseIcon * iconScale, 26), 88)
                    let iconFont: CGFloat = iconSize * 0.5
                    let rowSpacing: CGFloat = isCompact ? 6 * scale : 8 * scale
                    let pad: CGFloat = 14 * scale
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: AppCornerRadius.card)
                            .fill(Color(.systemGray5))
                            .overlay(
                                RoundedRectangle(cornerRadius: AppCornerRadius.card)
                                    .strokeBorder(.white.opacity(0.12))
                            )
                            .shadow(color: .appBlack.opacity(0.05), radius: 6, x: 0, y: 3)
                        VStack(alignment: .center, spacing: rowSpacing) {
                            Image(isWeek ? "weekCalendar" : "todayCalendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize, height: iconSize)
                                .background(Circle().fill(.appWhite.opacity(0.25)))
                            Text(isWeek ? "Week" : "Day")
                                .font(.system(size: titleFont, weight: .semibold))
                                .foregroundStyle(.black.opacity(0.85))
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(pad)
                    }
                    .frame(width: cardWidth, height: rowHeight)
                    .padding(.trailing, horizontalPadding)
                    .onTapGesture { isWeek.toggle() }
                }
                
                ExpandableListCard(
                    title: "Inventory items",
                    subtitle: "Required inventory for today's jobs",
                    items: [
                        ExpandableListItem(title: "Meter/Radio,5/8,REMPT", value: "12"),
                        ExpandableListItem(title: "Radio,8\" ,REMPT", value: "5"),
                        ExpandableListItem(title: "Meter,5\",REMPT", value: "7"),
                    ],
                    horizontalPadding: 12
                )
                
                ResponsiveTabBar(tabs: tabs, selectedIndex: $selectedIndex)
                tabs[selectedIndex].view
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }.padding(.top, AppPadding.medium)
            
        }
    }
}

private struct MetricCard: View {
    let width: CGFloat
    let title: String
    let value: String
    let iconName: String
    let iconColor: Color
    let gradient: [Color]
    
    private var ratio: CGFloat { 140.0 / 260.0 }
    private var scale: CGFloat { max(0.6, min(1.4, width / 260.0)) }
    
    var body: some View {
        let pad: CGFloat = 14 * scale
        let isCompact = width < 110
        
        let iconScale = width / 200.0
        let baseIcon: CGFloat = isCompact ? 30 : 40
        let iconSize: CGFloat = min(max(baseIcon * iconScale, 26), 88)
        let iconFont: CGFloat = iconSize * 0.5
        let titleFont: CGFloat = (FontSize.large) * scale
        let valueFont: CGFloat = (FontSize.xlarge) * scale
        let rowSpacing: CGFloat = isCompact ? 6 * scale : 8 * scale
        let hSpacing: CGFloat = isCompact ? 8 * scale : 10 * scale
        
        ZStack {
            RoundedRectangle(cornerRadius: AppCornerRadius.card)
                .fill(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(
                    RoundedRectangle(cornerRadius: AppCornerRadius.card)
                        .strokeBorder(.white.opacity(0.12))
                )
                .shadow(color: .appBlack.opacity(0.05), radius: 6, x: 0, y: 3)
            
            VStack(alignment: .center, spacing: rowSpacing) {
                HStack(alignment: .center, spacing: hSpacing) {
                    Circle()
                        .fill(.white.opacity(0.25))
                        .frame(width: iconSize, height: iconSize)
                        .overlay(
                            Image(systemName: iconName)
                                .font(.system(size: iconFont, weight: .semibold))
                                .foregroundStyle(iconColor)
                        )
                    Text(value)
                        .font(.system(size: valueFont, weight: .bold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(.black.opacity(0.9))
                }
                Text(title)
                    .font(.system(size: titleFont, weight: .semibold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .foregroundStyle(.black.opacity(0.85))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(pad)
        }
        .frame(width: width, height: width * ratio)
    }
}

#Preview {
    JobsMainView()
}
