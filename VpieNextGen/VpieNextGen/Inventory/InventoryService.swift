import Foundation

struct InventoryService: InventoryServicing {
    private let delay: UInt64 = 600_000_000 
    
    func fetchCurrentLocation() async throws -> String {
        try await Task.sleep(nanoseconds: delay)
        return "Technician"
    }
    
    func fetchCurrentUtility() async throws -> String {
        try await Task.sleep(nanoseconds: delay)
        return "Columbus"
    }
    
    func scanWithCamera() async throws -> ScanResult {
        try await Task.sleep(nanoseconds: delay)
        let exists = Bool.random()
        let msg = exists ? "Exists in inventory" : "Does not exist in inventory"
        return ScanResult(code: randomCode(),  message: msg, date: Date())
    }
    
    func scanWithExternalDevice() async throws -> ScanResult {
        try await Task.sleep(nanoseconds: delay)
        let exists = Bool.random()
        let msg = exists ? "Exists in inventory" : "Does not exist in inventory"
        return ScanResult(code: randomCode(), message: msg, date: Date())
    }
    
    private func randomCode() -> String {
        String((0..<10).map { _ in "0123456789".randomElement()! })
    }
}
