//
//  ExpandableActivityCard.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 2.12.2025.
//

import SwiftUI

public struct ExpandableCustomCard<Content: View>: View {
    public var title: String
    public var subtitle: String? = nil
    public var horizontalPadding: CGFloat
    public var showAddButton: Bool
    public var onAddButtonTapped: (() -> Void)?
    @State private var isExpanded: Bool
    private let content: () -> Content
    
    public init(title: String,
                subtitle: String? = nil,
                isInitiallyExpanded: Bool = false,
                horizontalPadding: CGFloat? = nil,
                showAddButton: Bool = true,
                onAddButtonTapped: (() -> Void)? = nil,
                @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.horizontalPadding = horizontalPadding ?? AppPadding.small
        self.showAddButton = showAddButton
        self.onAddButtonTapped = onAddButtonTapped
        self._isExpanded = State(initialValue: isInitiallyExpanded)
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            header
            if isExpanded {
                VStack(spacing: 0) {
                    content()
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
                .padding(.top, 6)
            }
        }.cardStyle(padding: AppPadding.small)
        .animation(.easeInOut(duration: 0.25), value: isExpanded)
        
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            Button(action: { isExpanded.toggle() }) {
                HStack(spacing: 8) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.system(size: FontSize.large, weight: .semibold))
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
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: FontSize.standard, weight: .semibold))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .foregroundColor(.vpieGrayWithDarkMode)
                        .frame(width: 28, height: 28)
                        .accessibilityHidden(true)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityAddTraits(.isButton)
            
            Spacer()
            
            if showAddButton {
                Button(action: {
                    onAddButtonTapped?()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: FontSize.standard, weight: .semibold))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .foregroundColor(.vpieGrayWithDarkMode)
                        .frame(width: 28, height: 28)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ExpandableCustomCard(
            title: "Forms",
            isInitiallyExpanded: true,
            showAddButton: true,
            onAddButtonTapped: {
                print("Add form tapped")
            }
        ) {
            VStack(spacing: 0) {
                ForEach(Array([
                    "Columbus Water Install",
                    "Columbus Meter Reading",
                    "Employee Equipment Affidavit"
                ].enumerated()), id: \.offset) { index, formTitle in
                    Button(action: {
                        print("\(formTitle) tapped")
                    }) {
                        Text(formTitle)
                            .font(.system(size: FontSize.standard, weight: .bold))
                            .dynamicTypeSize(.xSmall ... .accessibility5)
                            .foregroundColor(Color.vpieGray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, AppPadding.small)
                    }
                    .buttonStyle(.plain)
                    
                    if index < 2 {
                        Line()
                            .stroke(.vpieGrayWithDarkMode.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [2]))
                            .frame(height: 0.5)
                            .padding(.vertical, 8)
                    }
                }
            }
        }
        
        ExpandableCustomCard(
            title: "Notes",
            isInitiallyExpanded: true,
            showAddButton: true,
            onAddButtonTapped: {
                print("Add note tapped")
            }
        ) {
            VStack(spacing: 8) {
                ForEach(0..<3, id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "note.text")
                            .font(.system(size: FontSize.standard))
                            .foregroundColor(.vpieGray)
                            .frame(width: 24, height: 24)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Note \(index + 1)")
                                .font(.system(size: FontSize.standard, weight: .semibold))
                                .foregroundColor(.appBlack)
                            Text("This is a sample note content This is a sample note content This is a sample note content...")
                                .font(.system(size: FontSize.thin))
                                .foregroundColor(.vpieGray)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, AppPadding.medium)
                    .padding(.vertical, AppPadding.small)
                    
                    if index < 2 {
                        Line()
                            .stroke(.vpieGrayWithDarkMode.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [2]))
                            .frame(height: 0.5)
                            .padding(.vertical, 8)
                    }
                }
            }
        }
        
        ExpandableCustomCard(
            title: "Photos",
            subtitle: "",
            isInitiallyExpanded: false,
            showAddButton: true,
            onAddButtonTapped: {
                print("photo tapped")
            }
        ) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 8) {
                ForEach(0..<6, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.vpieGray)
                        )
                }
            }
            .padding(.horizontal, AppPadding.medium)
            .padding(.vertical, AppPadding.small)
        }
    }
}
