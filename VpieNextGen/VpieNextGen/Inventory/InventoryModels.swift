import Foundation
import SwiftUI

struct ScanResult: Identifiable, Equatable {
    let id = UUID()
    let code: String
    var message: String? = nil
    let date: Date
}


protocol InventoryServicing: Sendable {
    func fetchCurrentLocation() async throws -> String
    func fetchCurrentUtility() async throws -> String
    func scanWithCamera() async throws -> ScanResult
    func scanWithExternalDevice() async throws -> ScanResult
}
