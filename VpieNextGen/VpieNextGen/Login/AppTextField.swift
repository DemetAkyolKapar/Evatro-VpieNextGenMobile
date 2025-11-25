// This duplicate AppTextField has been superseded by CommonUI/AppTextField.swift.
// You can remove this file from the target.
// filepath: /Users/demetakyol/Desktop/VpieNextGen/VpieNextGen/Login/AppTextField.swift
// Reusable text input with top label (notched outline style)

import SwiftUI
import UIKit

struct AppTextField: View {
    let label: String
    @Binding var text: String

    var placeholder: String = ""
    var isSecure: Bool = false
    var showsSecureToggle: Bool = false
    var leadingSystemImage: String? = nil

    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var textInputAutocapitalization: TextInputAutocapitalization? = nil
    var autocorrectionDisabled: Bool = false
    var submitLabel: SubmitLabel = .done

    var errorMessage: String? = nil

    // Optional custom background for the label notch; defaults to system background
    var labelBackground: Color? = nil

    @State private var isRevealed: Bool = false
    @Environment(\.colorScheme) private var colorScheme

    init(
        label: String,
        text: Binding<String>,
        placeholder: String = "",
        isSecure: Bool = false,
        showsSecureToggle: Bool = false,
        leadingSystemImage: String? = nil,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        textInputAutocapitalization: TextInputAutocapitalization? = nil,
        autocorrectionDisabled: Bool = false,
        submitLabel: SubmitLabel = .done,
        errorMessage: String? = nil,
        labelBackground: Color? = nil
    ) {
        self.label = label
        self._text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.showsSecureToggle = showsSecureToggle
        self.leadingSystemImage = leadingSystemImage
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.textInputAutocapitalization = textInputAutocapitalization
        self.autocorrectionDisabled = autocorrectionDisabled
        self.submitLabel = submitLabel
        self.errorMessage = errorMessage
        self.labelBackground = labelBackground
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .topLeading) {
                // Background + border
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(fieldBackground)
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(borderColor, lineWidth: 1)

                // Content
                HStack(spacing: 12) {
                    if let icon = leadingSystemImage {
                        Image(systemName: icon)
                            .foregroundStyle(fieldTextColor.opacity(0.8))
                            .frame(width: 22)
                    }

                    Group {
                        if isSecure && !(showsSecureToggle && isRevealed) {
                            SecureField(placeholder.isEmpty ? label : placeholder, text: $text)
                        } else {
                            TextField(placeholder.isEmpty ? label : placeholder, text: $text)
                        }
                    }
                    .foregroundStyle(fieldTextColor)
                    .submitLabel(submitLabel)
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .textInputAutocapitalization(textInputAutocapitalization)
                    .autocorrectionDisabled(autocorrectionDisabled)

                    if isSecure && showsSecureToggle {
                        Button(action: { isRevealed.toggle() }) {
                            Image(systemName: isRevealed ? "eye.slash" : "eye")
                                .foregroundStyle(fieldTextColor.opacity(0.7))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 14)
                .padding(.top, 4) // extra space for the floating label notch

                // Floating label sitting on the border (notched)
                Text(label)
                    .font(.footnote)
                    .foregroundStyle(labelColor)
                    .padding(.horizontal, 6)
                    .background(notchBackground)
                    .lineLimit(1)
                    .offset(x: 14, y: -8)
            }

            if let error = errorMessage, !error.isEmpty {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
    }

    // MARK: - Styling
    private var fieldBackground: Color {
        if colorScheme == .dark { return Color.white.opacity(0.12) }
        return Color.black.opacity(0.05)
    }

    private var borderColor: Color {
        if let error = errorMessage, !error.isEmpty { return .red.opacity(0.9) }
        if colorScheme == .dark { return Color.white.opacity(0.25) }
        return Color.black.opacity(0.15)
    }

    private var fieldTextColor: Color {
        colorScheme == .dark ? .white : .primary
    }

    private var labelColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.85) : .secondary
    }

    private var notchBackground: some View {
        (labelBackground ?? Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
    }
}
