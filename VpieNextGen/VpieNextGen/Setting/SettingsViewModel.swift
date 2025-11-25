import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var versionText: String = ""

    init() {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            versionText = "VPie \(version) (\(build))"
        } else {
            versionText = "VPie"
        }
    }

    func logout() {
        // TODO: Wire to AuthService/Session when available
        print("Logout tapped")
    }
}
