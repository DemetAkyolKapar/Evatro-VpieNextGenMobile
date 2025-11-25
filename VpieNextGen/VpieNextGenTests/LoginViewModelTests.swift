import XCTest
@testable import VpieNextGen

final class LoginViewModelTests: XCTestCase {

    struct MockAuthService: AuthServicing {
        enum Mode { case success, wrongCreds }
        let mode: Mode
        func signIn(email: String, password: String) async throws -> UserSession {
            switch mode {
            case .success:
                return UserSession(id: UUID(), email: email, token: "tkn")
            case .wrongCreds:
                throw LoginError.wrongCredentials
            }
        }
    }

    func testSignInSuccess() async {
        let vm = await LoginViewModel(authService: MockAuthService(mode: .success))
        await MainActor.run {
            vm.credentials = LoginCredentials(email: "a@b.com", password: "123456")
        }
        await vm.signIn()
        await MainActor.run {
            XCTAssertNotNil(vm.session)
            XCTAssertNil(vm.error)
        }
    }

    func testSignInWrongCredentials() async {
        let vm = await LoginViewModel(authService: MockAuthService(mode: .wrongCreds))
        await MainActor.run {
            vm.credentials = LoginCredentials(email: "a@b.com", password: "bad")
        }
        await vm.signIn()
        await MainActor.run {
            XCTAssertNil(vm.session)
            XCTAssertEqual(vm.error, .wrongCredentials)
        }
    }
}
