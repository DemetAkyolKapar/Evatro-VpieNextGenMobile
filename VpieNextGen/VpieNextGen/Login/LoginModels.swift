//
//  LoginModels.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 4.11.2025.
//

import Foundation


// MARK: - Models

struct LoginCredentials: Equatable, Codable {
    var email: String = ""
    var password: String = ""
}

enum LoginError: LocalizedError, Equatable {
    case emptyFields
    case invalidEmail
    case weakPassword
    case wrongCredentials
    case network

    
    var errorDescription: String? {
        switch self {
        case .emptyFields: return "Please enter your e‑mail and password."
        case .invalidEmail: return "Please enter a valid e‑mail address."
        case .weakPassword: return "Password must be at least 6 characters."
        case .wrongCredentials: return "E‑mail or password is incorrect."
        case .network: return "Network error. Please try again."
        }
    }
}

 struct LoginResponseDTO: Decodable {
    let userId: UUID
    let token: String
}

struct UserSession: Equatable, Codable {
    let id: UUID
    let email: String
    let token: String
}
