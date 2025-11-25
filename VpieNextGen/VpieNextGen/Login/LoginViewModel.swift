//
//  LoginViewModel.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 4.11.2025.
//

import Foundation

import Combine

final class LoginViewModel: ObservableObject {
    @Published var credentials = LoginCredentials()
    @Published var isPasswordVisible: Bool = false

    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: LoginError?
    @Published private(set) var session: UserSession?

    private let authService: AuthServicing

    init(authService: AuthServicing) {
        self.authService = authService
    }

    var isSignInDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty || isLoading
    }

    func signIn() async {
        error = nil
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await authService.signIn(email: credentials.email.trimmingCharacters(in: .whitespacesAndNewlines),
                                                      password: credentials.password)
            session = result
        } catch let loginError as LoginError {
            self.error = loginError
        } catch {
            self.error = .network
        }
    }

    func togglePasswordVisibility() { isPasswordVisible.toggle() }
}
