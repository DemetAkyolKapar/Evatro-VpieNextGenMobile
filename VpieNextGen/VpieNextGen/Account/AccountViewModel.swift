import Foundation
import SwiftUI

final class AccountViewModel: ObservableObject {
    private let service: AccountServicing

    @Published var nameSurname: String = ""
    @Published var password: String = ""
    @Published var newPassword: String = ""

    @Published var syncInventoryData: Bool = true {
        didSet { onToggleSyncInventoryData() }
    }

    @Published var isSaving: Bool = false
    @Published var errorMessage: String?

    init(service: AccountServicing) {
        self.service = service
    }

    func saveProfile() async {
        guard !isSaving else { return }
        isSaving = true
        defer { isSaving = false }
        do {
            try await service.updateProfile(nameSurname: nameSurname,
                                            password: password.isEmpty ? nil : password,
                                            newPassword: newPassword.isEmpty ? nil : newPassword)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func onToggleSyncInventoryData()  {
       // userdefaultsda tut
    }

    func deleteUser() {
        Task {
            do { try await service.deleteUser() }
            catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
