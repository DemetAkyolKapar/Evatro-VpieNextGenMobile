//
//  JobHistoryView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 3.12.2025.
//

import SwiftUI

struct JobFormHistoryItem: Identifiable, Hashable {
    let id = UUID()
    let formName: String
    let formDateTime: String
    let jobDateTime: String
    let technicianName: String
}

protocol JobHistoryVMProtocol: ObservableObject {
    var items: [JobFormHistoryItem] { get }
}

final class JobHistoryViewModel: JobHistoryVMProtocol {
    @Published var items: [JobFormHistoryItem]
    
    init(items: [JobFormHistoryItem] = []) {
        self.items = items
    }
}

private struct HistoryItemCard: View {
    let item: JobFormHistoryItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.standard) {
            header
            Line()
                .stroke(.vpieGrayWithDarkMode.opacity(0.5),
                        style: StrokeStyle(lineWidth: 1, dash: [2]))
                .frame(height: 0.5)
            infoRows
        }
        .cardStyle()
        .padding(AppPadding.small)
    }
    
    private var header: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color(.appBackground))
                    .frame(width: 48, height: 48)
                Image(systemName: "doc.text")
                    .font(.system(size: 18, weight: .semibold))
                    .dynamicTypeSize(.xSmall ... .accessibility5)
                    .foregroundColor(.appBlack)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.formName)
                    .font(.system(size: FontSize.standard, weight: .bold))
                    .dynamicTypeSize(.xSmall ... .accessibility5)
                    .foregroundColor(.appBlack)
                Text(item.formDateTime)
                    .itemStyle()
            }
        }
    }
    
    private var infoRows: some View {
        VStack(alignment: .leading, spacing: AppSpacing.thin) {
            HStack(alignment: .top, spacing: 0) {
                leadingIcon("calendar")
                (Text("job_date") + Text("two_point_space"))
                    .itemStyle()
                    .foregroundColor(.vpieGray)
                
                Text(item.jobDateTime)
                    .itemStyle()
                    .foregroundColor(.vpieGray)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack(alignment: .top, spacing: 0) {
                leadingIcon("person")
                (Text("technician") + Text("two_point_space"))
                    .itemStyle()
                    .foregroundColor(.vpieGray)
                Text(item.technicianName)
                    .itemStyle()
                    .foregroundColor(.vpieGray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    @ViewBuilder
    private func leadingIcon(_ systemName: String) -> some View {
        Image(systemName: systemName)
            .font(.system(size: FontSize.standard))
            .dynamicTypeSize(.xSmall ... .accessibility5)
            .foregroundColor(.vpieGray)
            .frame(width: 28, alignment: .leading)
            .padding(.trailing, AppPadding.medium)
    }
}

struct JobHistoryView<VM: JobHistoryVMProtocol>: View {
    @StateObject private var vm: VM
    @Environment(\.deviceBehavior) private var deviceBehavior
    
    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: 16, alignment: .top),
            count: (deviceBehavior != .pad) ? 2 : 1
        )
    }
    
    init(viewModel: VM) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(vm.items) { item in
                    HistoryItemCard(item: item)
                }
            }
        }
    }
}

#Preview {
    let sampleItems = [
        JobFormHistoryItem(
            formName: "Columbus Water Install",
            formDateTime: "12/03/2025 10:15",
            jobDateTime: "12/03/2025 09:30-10:30",
            technicianName: "Sheldon Harrison"
        ),
        JobFormHistoryItem(
            formName: "Columbus Incomplete Work Order",
            formDateTime: "12/02/2025 14:40",
            jobDateTime: "12/02/2025 13:30-15:30",
            technicianName: "Robert Paine"
        ),
        
        JobFormHistoryItem(
            formName: "Columbus OH Audit",
            formDateTime: "12/02/2025 16:40",
            jobDateTime: "12/02/2025 15:30-16:30",
            technicianName: "Antonis Rammos"
        ),
        
        JobFormHistoryItem(
            formName: "Columbus Incomplete Work Order",
            formDateTime: "12/02/2025 16:40",
            jobDateTime: "12/02/2025 15:30-16:30",
            technicianName: "Robert Paine"
        )
    ]
    return JobHistoryView(viewModel: JobHistoryViewModel(items: sampleItems))
}
