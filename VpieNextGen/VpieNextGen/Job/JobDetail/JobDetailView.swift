//
//  JobDetailView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 2.12.2025.
//

import SwiftUI

struct JobDetailView: View {
    @State private var selectedIndex = 0
  
    private var tabs: [TabItem] = [
        
        TabItem(title: "New Job", systemImage: "hammer", view: AnyView(NewJobView())),
        
        TabItem(title: "Info", systemImage: "info.circle", view: AnyView(JobListView(vm: JobListViewModel(service: VpieJobService())))),
        
        TabItem(title: "History", systemImage: "clock", view: AnyView(    JobHistoryView(viewModel: JobHistoryViewModel(items:    [
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
        ]))
)),
    ]
    
    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                ResponsiveTabBar(tabs: tabs, selectedIndex: $selectedIndex)
                tabs[selectedIndex].view
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

#Preview {
    JobDetailView()
}
