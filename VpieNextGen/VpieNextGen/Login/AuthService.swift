//
//  AuthService.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 4.11.2025.
//

import Foundation

protocol AuthServicing {
    func signIn(email: String, password: String) async throws -> UserSession
}
struct AuthService: AuthServicing {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func signIn(email: String, password: String) async throws -> UserSession {
        guard !email.isEmpty, !password.isEmpty else { throw LoginError.emptyFields }
        guard email.contains("@"), email.contains(".") else { throw LoginError.invalidEmail }
        
        
        // TODO: Network class yazılamlı
        guard password.count >= 6 else { throw LoginError.weakPassword }
        var request = URLRequest(url: URL(string: "--")!)

        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let http = response as? HTTPURLResponse else { throw LoginError.network }

            switch http.statusCode {
            case 200...299:
                let decoded = try JSONDecoder().decode(LoginResponseDTO.self, from: data)
                return UserSession(id: decoded.userId, email: email, token: decoded.token)

            case 401:
                throw LoginError.wrongCredentials
            default:
                throw LoginError.network
            }
        }  catch {
            throw LoginError.wrongCredentials

        }
    }
}


