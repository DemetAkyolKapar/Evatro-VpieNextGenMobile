//
//  JobItemView.swift
//  VpieNextGen
//
//  Created by Demet Akyol on 13.11.2025.
//

import SwiftUI

protocol JobItemVMProtocol: ObservableObject {
    var orderNumber: NSDecimalNumber { get }
    var assetName: String { get }
    var planTime: String? { get }
    var statusText: String { get }
    var statusColor: Color { get }
    var phone: String? { get }
    var address: String? { get }
    func onDirections() async
    func onResume() async
}

struct JobItemView<VM: JobItemVMProtocol>: View {
    @StateObject private var vm: VM
    private let showBottomButtons: Bool
    
    init(viewModel: VM, showBottomButtons: Bool = true) {
        _vm = StateObject(wrappedValue: viewModel)
        self.showBottomButtons = showBottomButtons
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.standard) {
            header
            infoRows
            
            Line()
                .stroke(.vpieGrayWithDarkMode.opacity(0.5),
                        style: StrokeStyle(lineWidth: 1, dash: [2]))
                .frame(height: 0.5)
            dynamicRows
            if showBottomButtons {
                bottomButtons
            }
        }
        .cardStyle()
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 10) {
                ZStack {
                    Circle()
                        .fill(Color(.appBackground))
                        .frame(width: 60, height: 60)
                    
                    Text("\(vm.orderNumber)")
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 60, height: 60)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .foregroundColor(.appBlack)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(vm.assetName)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.appBlack)
                    
                    HStack(spacing: 12) {
                        if let time = vm.planTime, !time.isEmpty {
                            
                            HStack(spacing: 6) {
                                Image(systemName: "clock")
                                Text(time)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.leading)
                            }
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.vpieGray)
                        }
                        Spacer()
                        statusPill
                    }
                }
            }
        }
    }
    
    private var statusPill: some View {
        Text(vm.statusText)
            .font(.system(size: 12, weight: .semibold))
            .dynamicTypeSize(.xSmall ... .accessibility5)
            .foregroundColor(vm.statusColor)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(
                Capsule().fill(vm.statusColor.opacity(0.12))
            )
    }
    
    private var infoRows: some View {
     
        VStack(alignment: .leading, spacing: AppSpacing.thin) {
            HStack(alignment: .top, spacing: 0) {
                leadingIcon("wrench")
                HStack(spacing: 6) {
                    Text("Survey")
                        .itemStyle()
                        .foregroundColor(.vpieGray)
                    Spacer()
                    if let trimmed = vm.phone?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmed.isEmpty {
                        HStack(spacing: 6) {
                            Image(systemName: "phone")
                                .font(.system(size: FontSize.standard))
                                .foregroundColor(.vpieGray)
                                .dynamicTypeSize(.xSmall ... .accessibility5)
                            Text(trimmed)
                                .itemStyle()
                                .foregroundColor(.vpieGray)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .minimumScaleFactor(0.75)
                        }
                    }
                }
            }
            if let trimmed = vm.address?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmed.isEmpty {
                HStack(alignment: .center, spacing: 0) {
                    leadingIcon("mappin.and.ellipse")
                    Text(trimmed)
                        .itemStyle()
                        .foregroundColor(.vpieGray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .multilineTextAlignment(.leading)
                        .accessibilityLabel("Address \(trimmed)")
                }
            }
        }
    }
    
    @ViewBuilder
    private func leadingIcon(_ systemName: String) -> some View {
        Image(systemName: systemName)
            .font(.system(size: FontSize.standard))
            .foregroundColor(.vpieGray)
            .frame(width: 28, alignment: .leading)
            .padding(.trailing, 8)
//            .dynamicTypeSize(.xSmall ... .accessibility5)
    }
    
//    @available(iOS 16.0, *)
//    private var dynamicGrid: some View {
//
//        FlowLayout(spacing: 12) {
//            if let lastRead = vm.lastReadProvided, !lastRead.isEmpty {
//                Text("Last Provided Provided: \(lastRead)")
//                    .itemStyle()
//            }
//            if let radio = vm.oldRadioId, !radio.isEmpty {
//                Text("Old Radio ID: \(radio)")
//                    .itemStyle()
//                Text("Old R: \(radio)")
//                    .itemStyle()
//                Text("Old Provided Provided: \(radio)")
//                    .itemStyle()
//                Text("Old  Provided: \(radio)")
//                    .itemStyle()
//                Text("Olwefwed R: \(radio)")
//                    .itemStyle()
//            }
//
//        }
//    }
//    bu kısım ihtiyaç olursa geri açılabilir sığdığı kadar sığmazsa alt satıra geç geliştirmesi
    
        private var dynamicRows: some View {

        let items = [
            LayoutItem(text: "Old Meter : 1232324", layout: "1|1"),
            LayoutItem(text: "LRP : 7227401377", layout: "1|2"),
            LayoutItem(text: "Last Provided : 72274013", layout: "2"),
            LayoutItem(text: "Radio : 3663", layout: "3|1"),
            LayoutItem(text: "Radio2 : 3663", layout: "4"),
            LayoutItem(text: "Notes : revalidate", layout: "5|2"),
            LayoutItem(text: "New Radio : 3663", layout: "5|1"),
            LayoutItem(text: "Old Radio  : 45346666", layout: "3|2"),
        ]
         return FixedGridLayout(items: items)
    }
    
    private var bottomButtons: some View {
        HStack(spacing : AppSpacing.large) {
            Image(systemName: "arrow.triangle.turn.up.right.circle")
                .font(.system(size: FontSize.xlarge))
                .foregroundColor(Color.vpieGray)
                .dynamicTypeSize(.xSmall ... .accessibility5)
            Spacer()
            BorderedButton(
                title: "resume",
                titleColor: Color.appWhite,
                backgroundColor: .appBlack,
                borderColor: Color.buttonBackground,
                cornerRadius: AppCornerRadius.button,
                verticalPadding: AppPadding.extraSmall
            ) {
                await vm.onResume()
            }
        }.padding(.top, AppPadding.medium)
    }
}

 class MockJobItemVM: JobItemVMProtocol {
    @MainActor init(sample: NSDecimalNumber = 1) {
        self.orderNumber = sample
        self.assetName = sample == 1 ? "1600 DUBLIN RD" : "1405 DUBLIN RD"
        self.planTime = sample == 1 ? "10/10/2025 9:30-10:30" : "11/10/2025 11:30-11:30"
        self.statusText = sample == 1 ? "Assigned" : "In Progress"
        self.statusColor = sample == 1 ? .blue : .orange
        self.phone = sample == 1 ? "6142249161" : "6148887777"
        self.address = sample == 1 ? "1600 DUBLIN RD, COLUMBUS" : "1405 DUBLIN RD, COLUMBUS"
    }
    
    @Published var orderNumber: NSDecimalNumber = 123486
    @Published var assetName: String = ""
    @Published var planTime: String? = nil
    @Published var statusText: String = "Assigned"
    @Published var statusColor: Color = .blue
    @Published var phone: String? = nil
    @Published var address: String? = nil
    
    func onDirections() async {}
    func onResume() async {}
}

#Preview {
    VStack(spacing: 16) {
        JobItemView(viewModel: MockJobItemVM(sample: 1))
        JobItemView(viewModel: MockJobItemVM(sample: 234565), showBottomButtons: false)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}

//@available(iOS 16.0, *)
//struct FlowLayout: Layout {
//    var spacing: CGFloat = 24
//
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//        let containerWidth = proposal.width ?? 0
//        var currentX: CGFloat = 0
//        var lineHeight: CGFloat = 0
//        var totalHeight: CGFloat = 0
//
//        for index in subviews.indices {
//            let subview = subviews[index]
//            let subviewSize = subview.sizeThatFits(.unspecified)
//            if currentX + subviewSize.width > containerWidth {
//                totalHeight += lineHeight + (totalHeight > 0 ? spacing : 0)
//                currentX = 0
//                lineHeight = 0
//            }
//            currentX += subviewSize.width + spacing
//            lineHeight = max(lineHeight, subviewSize.height)
//        }
//        totalHeight += lineHeight
//        return CGSize(width: containerWidth, height: totalHeight)
//    }
//
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        var currentX: CGFloat = bounds.minX
//        var currentY: CGFloat = bounds.minY
//        var lineHeight: CGFloat = 0
//
//        for index in subviews.indices {
//            let subview = subviews[index]
//            let subviewSize = subview.sizeThatFits(.unspecified)
//
//            if currentX + subviewSize.width > bounds.maxX {
//                currentY += lineHeight + spacing
//                currentX = bounds.minX
//                lineHeight = 0
//            }
//            subview.place(at: CGPoint(x: currentX, y: currentY), anchor: .topLeading, proposal: .unspecified)
//
//            currentX += subviewSize.width + spacing
//            lineHeight = max(lineHeight, subviewSize.height)
//        }
//    }
//}


@available(iOS 16.0, *)
extension View {
    func itemStyle() -> some View {
        self
            .font(.system(size: FontSize.thin))
            .foregroundColor(Color.vpieGray)
            .dynamicTypeSize(.xSmall ... .accessibility5)
    }
}
