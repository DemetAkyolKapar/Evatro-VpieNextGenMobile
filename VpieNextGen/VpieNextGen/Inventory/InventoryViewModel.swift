import Foundation
import SwiftUI

final class InventoryViewModel: ObservableObject {
    private let service: InventoryServicing

    @Published var location: String = ""
    @Published var utility: String = ""
    @Published var technician: String = ""
    @Published var isDefective: Bool = false
    @Published var scanHistory: [ScanResult] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil

    init(service: InventoryServicing) {
        self.service = service
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            async let loc = service.fetchCurrentLocation()
            async let util = service.fetchCurrentUtility()
            let (l, u) = try await (loc, util)
            location = l
            utility = u
        } catch {
            self.error = ""
        }
    }
    
    func scanCamera() async {
        await performScan { try await service.scanWithCamera() }
    }
    
    func scanExternal() async {
        await performScan { try await service.scanWithExternalDevice() }
    }
    
    private func performScan(_ action: () async throws -> ScanResult) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await action()
            scanHistory.insert(result, at: 0)
        } catch {
            self.error = ""
        }
    }
    
    func addSample(code: String = "099612246", exists: Bool = false, message: String? = nil) {
        let msg = message ?? (exists ? "Exists in inventory" : "Does not exist in inventory not exist in inventory not exist in inventory")
        let sample = ScanResult(code: code, message: msg, date: Date())
        scanHistory.insert(sample, at: 0)
    }
}
