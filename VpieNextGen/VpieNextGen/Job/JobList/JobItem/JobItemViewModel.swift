//  JobItemViewModel.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 13.11.2025.
//

import SwiftUI

final class JobItemViewModel: ObservableObject {
    struct Item: Identifiable, Equatable {
        let id: UUID
        var orderNumber: Int // the big circle number (1,2,...) on the left
        var clientName: String // e.g. "1600 DUBLIN RD"
        var planTime: String? // e.g. "09:30"
        var status: Status
        var phone: String?
        var oldMeterNumber: String?
        var lrp: String?
        var oldRadioId: String?
        var lastReadProvided: String?
        var address: String?

        init(id: UUID = UUID(), orderNumber: Int, clientName: String, planTime: String? = nil, status: Status, phone: String? = nil, oldMeterNumber: String? = nil, lrp: String? = nil, oldRadioId: String? = nil, lastReadProvided: String? = nil, address: String? = nil) {
            self.id = id
            self.orderNumber = orderNumber
            self.clientName = clientName
            self.planTime = planTime
            self.status = status
            self.phone = phone
            self.oldMeterNumber = oldMeterNumber
            self.lrp = lrp
            self.oldRadioId = oldRadioId
            self.lastReadProvided = lastReadProvided
            self.address = address
        }
    }

    enum Status: String, CaseIterable, Equatable {
        case assigned = "Assigned"
        case inProgress = "In Progress"
        case completed = "Completed"
        case paused = "Paused"
        case cancelled = "Cancelled"

        var color: Color {
            switch self {
            case .assigned: return .blue
            case .inProgress: return .orange
            case .completed: return .green
            case .paused: return .gray
            case .cancelled: return .red
            }
        }
    }

    @Published var item: Item

    let onDirections: () async -> Void
    let onResume: () async -> Void

    init(item: Item,
         onDirections: @escaping () async -> Void = {},
         onResume: @escaping () async -> Void = {}) {
        self.item = item
        self.onDirections = onDirections
        self.onResume = onResume
    }
}
