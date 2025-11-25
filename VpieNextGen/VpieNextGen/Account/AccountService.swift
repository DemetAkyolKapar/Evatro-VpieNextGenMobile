// filepath: VpieNextGen/Account/AccountViewModel.swift
import Foundation
import SwiftUI

import Foundation

public protocol AccountServicing {
    func setEmailVerified(_ verified: Bool) async throws
    func updateProfile(nameSurname: String, password: String?, newPassword: String?) async throws
    func deleteUser() async throws
}

public struct AccountService: AccountServicing {
    public init() {}

    public func setEmailVerified(_ verified: Bool) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    public func updateProfile(nameSurname: String, password: String?, newPassword: String?) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    public func deleteUser() async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }
}
