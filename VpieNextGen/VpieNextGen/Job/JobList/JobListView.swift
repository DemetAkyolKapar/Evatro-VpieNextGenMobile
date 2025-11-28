//
//  JobListView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 13.11.2025.
//

import SwiftUI

struct JobListView: View {
   
    @StateObject var vm: JobListViewModel

    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.deviceBehavior) private var deviceBehavior

    private var isTwoColumn: Bool {
        deviceBehavior == .pad || hSizeClass == .regular
    }

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: 16, alignment: .top),
            count: isTwoColumn ? 2 : 1
        )
    }

    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            content
        }
        .task(id: vm.jobs.isEmpty) {
            if vm.jobs.isEmpty {
//                await vm.load()
            }
        }
    }

    @ViewBuilder private var content: some View {
        if vm.isLoading {
            ProgressView().progressViewStyle(.circular)
        } else if let msg = vm.errorMessage {
            VStack(spacing: 12) {
                Text(msg).foregroundColor(.errorMain)
                    .dynamicTypeSize(.xSmall ... .accessibility5)
                
                Button("Retry") { Task { await vm.load() } }
            }
        } else if vm.jobs.isEmpty {
            VStack(spacing: 12) {
                Text("No jobs available").foregroundColor(.vpieGray)
                    .dynamicTypeSize(.xSmall ... .accessibility5)
                    .font(.system(size: FontSize.standard))
                
                Button("Reload") { Task { await vm.load() } }
                    .foregroundColor(.appBlack)
                    .fontWeight(.bold)
                    .font(.system(size: FontSize.standard))

            }
        } else {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                    ForEach(vm.jobs, id: \.id) { jobVM in
                        JobItemView(viewModel: jobVM)
                    }
                }.refreshable {
                    await vm.load()
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    JobListView(vm: JobListViewModel(service: VpieJobService()))
}
