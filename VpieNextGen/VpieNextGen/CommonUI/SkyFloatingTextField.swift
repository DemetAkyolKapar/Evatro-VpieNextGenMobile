//
//  SkyFloatingTextField.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 11.11.2025.
//

import SwiftUI

enum TextFieldType {
    case secureField
    case textField
}

struct SkyFloatingTextField: View {
    var placeholder: String
    @Binding var text: String
    var textFieldType: TextFieldType
    @State private var isSecured: Bool = true
    @FocusState private var isFocused: Bool
    
    private var isRaised: Bool { isFocused || !text.isEmpty }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.vpieGrayWithDarkMode, lineWidth: 0.3)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.cardBackground))
            HStack(spacing: 12) {
                if textFieldType == .secureField && isSecured {
                    SecureField("", text: $text)
                        .focused($isFocused)
                        .foregroundColor(Color.appBlack)
                        .font(.system(size: FontSize.standard  ))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .autocapitalization(.none)

                } else {
                    TextField("", text: $text, onEditingChanged: { editing in
                        withAnimation(.easeInOut(duration: 0.2)) { }
                    })
                    .focused($isFocused)
                    .foregroundColor(Color.appBlack)
                    .font(.system(size: FontSize.standard  ))    
                    .dynamicTypeSize(.xSmall ... .accessibility5)
                    .autocapitalization(.none)

                }
                if textFieldType == .secureField {
                    Button { isSecured.toggle() } label: {
                        Image("Password")
                            .renderingMode(.template)
                            .foregroundColor(Color.appBlack)
                    }
                }
            }
            .padding(.horizontal, 12)
            Text(placeholder)
                .foregroundColor(Color.vpieGrayWithDarkMode)
                .font(.system(size: FontSize.standard,weight: isRaised ? .medium : .regular  ))
                .background(.cardBackground)
                .dynamicTypeSize(.xSmall ... .accessibility5)
                .offset(y: isRaised ? -24 : 0)
                .animation(.easeInOut(duration: 0.2), value: isRaised)
                .padding(.horizontal, 12)
        }
        .frame(height: 50)
        .onAppear { isSecured = textFieldType == .secureField }
    }
}

