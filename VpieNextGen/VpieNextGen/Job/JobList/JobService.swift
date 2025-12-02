import Foundation
import SwiftUI

protocol VpieJobServicing {
    func fetchJobs() async throws -> [JobItemViewModel.Item]
}

struct VpieJobService: VpieJobServicing {
    init() {}
    private let delay: UInt64 = 300_000_000

    func fetchJobs() async throws -> [JobItemViewModel.Item] {
        try await Task.sleep(nanoseconds: delay)
        // Mock data
        return [
            JobItemViewModel.Item(orderNumber: 12345, clientName: "1600 DUBLIN RD", planTime: "09:30", status: .assigned, phone: "6142249161", oldMeterNumber: "63521572", lrp: "4863470", oldRadioId: "72274013", lastReadProvided: nil, address: "1600 DUBLIN RD, COLUMBUS"),
            JobItemViewModel.Item(orderNumber: 2535355, clientName: "1405 DUBLIN RD", planTime: "10:30", status: .inProgress, phone: "6148887777", oldMeterNumber: "63521572", lrp: nil, oldRadioId: "72274013", lastReadProvided: "132600", address: "1405 DUBLIN RD, COLUMBUS"),
            JobItemViewModel.Item(orderNumber: 324242, clientName: "1701 DUBLIN RD", planTime: "11:30", status: .assigned, phone: nil, oldMeterNumber: "63521572", lrp: "4863470", oldRadioId: "72274013", lastReadProvided: nil, address: "1701 DUBLIN RD, COLUMBUS"),
            JobItemViewModel.Item(orderNumber: 4, clientName: "1802 DUBLIN RD", planTime: "12:30", status: .completed, phone: nil, oldMeterNumber: "63521572", lrp: nil, oldRadioId: "72274013", lastReadProvided: "132600", address: "1802 DUBLIN RD, COLUMBUS"),
            JobItemViewModel.Item(orderNumber: 5, clientName: "1903 DUBLIN RD", planTime: "13:30", status: .cancelled, phone: "6145550000", oldMeterNumber: "63521572", lrp: nil, oldRadioId: "72274013", lastReadProvided: nil, address: "1903 DUBLIN RD, COLUMBUS")
        ]
    }
}
