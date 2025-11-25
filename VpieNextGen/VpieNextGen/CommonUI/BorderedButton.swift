//
//  BorderedButton.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 11.11.2025.
//


import SwiftUI

struct BorderedButton: View {
    let title: LocalizedStringKey
    var titleColor: Color =  Color.appBlack
    var alignment : Alignment = Alignment.center
    var backgroundColor: Color = .appWhite
    var borderColor: Color = .appBlack
    var cornerRadius: CGFloat = AppCornerRadius.button
    var font: Font = .system(size: FontSize.standard, weight: .bold)
    var verticalPadding: CGFloat =  AppPadding.small
    var image: Image?  = nil
    var imageColor: Color = Color.appBlack
    let action: () async -> Void

    var body: some View {
        Button {
            Task { await action() }
        } label: {
            HStack(spacing: AppSpacing.tight) {  
                            if let image {
                                image
                                    .foregroundColor(imageColor)
                            }
                Text(title)
                    .padding(.vertical, verticalPadding)
                    .font(font)
                    .foregroundColor(titleColor)
                  
            }.frame(maxWidth: .infinity,alignment: alignment)
                .padding(verticalPadding)

        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(borderColor.opacity(0.7), lineWidth: 0.3)
        )
    }
    
}
