//
//  JobListView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 13.11.2025.
//

import SwiftUI
import Foundation


final class JobItemCardViewModel: JobItemVMProtocol {
    let id: UUID
    @Published var orderNumber: NSDecimalNumber
    @Published var assetName: String
    @Published var planTime: String?
    @Published var statusText: String
    @Published var statusColor: Color
    @Published var phone: String?
    @Published var oldMeterNumber: String?
    @Published var lrp: String?
    @Published var oldRadioId: String?
    @Published var lastReadProvided: String?
    @Published var address: String?

    private let directionsAction: () async -> Void
    private let resumeAction: () async -> Void

    init(item: JobItemViewModel.Item,
         onDirections: @escaping () async -> Void = {},
         onResume: @escaping () async -> Void = {}) {
        self.id = item.id
        self.orderNumber = item.orderNumber
        self.assetName = item.clientName
        self.planTime = item.planTime
        self.statusText = item.status.rawValue
        self.statusColor = item.status.color
        self.phone = item.phone
        self.oldMeterNumber = item.oldMeterNumber
        self.lrp = item.lrp
        self.oldRadioId = item.oldRadioId
        self.lastReadProvided = item.lastReadProvided
        self.address = item.address
        self.directionsAction = onDirections
        self.resumeAction = onResume
    }

    func onDirections() async { await directionsAction() }
    func onResume() async { await resumeAction() }
}

final class JobListViewModel: ObservableObject {
    @Published var jobs: [JobItemCardViewModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let service: VpieJobServicing

    init(service: VpieJobServicing) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        do {
            let items = try await service.fetchJobs()
            jobs = items.map { item in
                JobItemCardViewModel(
                    item: item,
                    onDirections: { await self.openDirections(for: item) },
                    onResume: { await self.resumeJob(item) }
                )
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    private func openDirections(for item: JobItemViewModel.Item) async {
        print("Open directions for order #\(item.orderNumber)")
    }

    private func resumeJob(_ item: JobItemViewModel.Item) async {
        print("Resume job order #\(item.orderNumber)")
    }
}
