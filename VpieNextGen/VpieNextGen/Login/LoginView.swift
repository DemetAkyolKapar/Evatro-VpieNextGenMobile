//
//  LoginView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 4.11.2025.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var vm: LoginViewModel
    @FocusState private var focusedField: Field?
    @State private var showError = false
    @State private var errorMessage = ""
    @Environment(\.horizontalSizeClass) var sizeClass
    
    init(viewModel: LoginViewModel = LoginViewModel(authService: AuthService())) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    
    enum Field { case email, password }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                ScrollView {
                    VStack {
                        VStack(spacing: AppSpacing.standard) {
                            VStack() {
                                
                                logoSection(geo: geo)
                                formSection(geo: geo)
                            }
                            .cardStyle(padding: AppPadding.large)
                            .padding(.top, sizeClass == .compact ? AppPadding.medium : AppPadding.xlarge )
                            Button(action: {}) {
                                Text("privacy_policy")
                                    .underline()
                                    .font(.system(size: FontSize.standard, weight: .medium))                    .foregroundColor(.vpieGray)
                            }
                            
                            Button(action: {}) {
                                Text("Powered by VEPO Solutions")
                                    .font(.system(size: FontSize.standard, weight: .medium))                    .foregroundColor(.vpieGray)
                            }
                        }
                    }
                }
                
                .onTapGesture { hideKeyboard() }
                
                if vm.isLoading {
                    Color.vpieGray.opacity(0.4).ignoresSafeArea()
                    ProgressView().tint(.white)
                }
                
            }
            .onSubmit {
                switch focusedField {
                case .email: focusedField = .password
                default:
                    guard !vm.isLoading else { return }
                    Task { await vm.signIn() }
                }
            }
            .onChange(of: vm.error) { newValue in
                if let err = newValue {
                    errorMessage = err.errorDescription ?? ""
                    showError = true
                }
            }
            .alert("Login", isPresented: $showError) {
                Button("OK") { showError = false }
            } message: {
                Text(errorMessage)
            }
            
        }
        
    }
    
    private func logoSection(geo: GeometryProxy) -> some View {
        let imageSize = (sizeClass == .compact ? 100 : 140) * 0.7
        
        return VStack(spacing: AppSpacing.standard) {
            Image("applogo")
                .resizable()
                .scaledToFill()
                .frame(width: imageSize, height: imageSize)
                .padding(.top,40)
                .padding(.bottom,40)
            
        }
        .frame(
            maxWidth: adaptiveCardWidth(for: geo),
            alignment: .center
        )
    }
    
    private func formSection(geo: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: AppSpacing.standard) {
            
            SkyFloatingTextField(placeholder: "E‑Mail", text: $vm.credentials.email, textFieldType: .textField)
            
            
            SkyFloatingTextField(placeholder: "Password", text: $vm.credentials.password, textFieldType: .secureField)
            
            Button {
                guard !vm.isLoading else { return }
                Task { await vm.signIn() }
            } label: {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.appWhite)
                    
                    Text("Sign In")
                        .fontWeight(.semibold)
                        .font(.system(size: FontSize.standard, weight: .medium))
                        .foregroundColor(.appWhite)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, geo.size.height * 0.02)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color("appBlack"))
                )
            }
            
            Button(action: {}) {
                Text("Forgot  password?")
                    .underline()
                    .font(.system(size: FontSize.standard, weight: .medium))                    .foregroundColor(.appBlack)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 4)
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        
        .frame(
            maxWidth: adaptiveCardWidth(for: geo),
            alignment: .center
        )
    }
    
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    private func adaptiveCardWidth(for geo: GeometryProxy) -> CGFloat {
        let screenWidth = geo.size.width
        let minWidth: CGFloat = 280
        let maxWidth: CGFloat = 600
        
        let width = screenWidth * 0.8
        return min(max(width, minWidth), maxWidth)
    }
}

#Preview {
    LoginView()
}

