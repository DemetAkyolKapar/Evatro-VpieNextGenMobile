import SwiftUI

struct InventoryView: View {
    @StateObject var vm: InventoryViewModel
    @Environment(\.deviceBehavior) private var deviceBehavior
    @Environment(\.colorScheme) var colorScheme
    
    @State private var contentHeight: CGFloat = 0
    @State private var screenHeight: CGFloat = 0
    @State private var isContentLargerThanScreen: Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Color("AppBackground").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.standard) {
                    
                    VStack(spacing: AppSpacing.standard) {
                        FloatingSubtitleRow(label: "Change Location", text: $vm.location, image: Image(systemName: "chevron.right"))
                        FloatingSubtitleRow(label: "Technician/Manager", text: $vm.technician, image: Image(systemName: "chevron.right"))
                        FloatingSubtitleRow(label: "Utility", text: $vm.utility, image: Image(systemName: "chevron.right"))
                    }
                    
                    HStack(spacing: AppSpacing.thin) {
                        Toggle("", isOn: $vm.isDefective)
                            .labelsHidden()
                        Text("mark_as_defective")
                            .font(.system(size: FontSize.standard))
                            .foregroundColor(.appBlack)
                        Spacer()
                    }
                    
                    AdaptiveStack(isHorizontal: deviceBehavior == .pad, spacing: 18) {
                        cameraScanButton
                        externalScanButton
                    }
                    
                    if !vm.scanHistory.isEmpty {
                        prepareScanHistory()
                    }
                    
                    if !isContentLargerThanScreen {
                        updateButton
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    Spacer(minLength: isContentLargerThanScreen ? 100 : 0)
                }
                .padding(.top, AppPadding.large)
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: ContentHeightKey.self, value: proxy.size.height)
                    }
                )
            }.scrollIndicators(.hidden)
                .cardStyle()
                .padding()
                .disabled(vm.isLoading)
                .overlay {
                    if vm.isLoading {
                        ZStack {
                            Color.vpieGray.opacity(0.4).ignoresSafeArea()
                            ProgressView()
                        }
                    }
                }
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear { screenHeight = proxy.size.height }
                    }
                )
                .onPreferenceChange(ContentHeightKey.self) { height in
                    withAnimation(.easeInOut(duration: 0.25)) {
                        contentHeight = height
                        isContentLargerThanScreen = contentHeight + 100 > screenHeight
                    }
                }
            
            if isContentLargerThanScreen {
                
                updateButton
                    .padding()
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.bottom, 16)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Inventory")
        .task { await vm.load() }
    }
    
    private func prepareScanHistory() -> some View {
        
        return VStack(alignment: .leading, spacing: AppSpacing.thin) {
            ForEach(vm.scanHistory) { item in
                VStack(alignment: .leading, spacing: AppSpacing.tight) {
                    HStack(spacing: 8) {
                        Image(systemName: "barcode")
                        Text(item.code)
                            .font(.system(size: FontSize.standard))
                            .foregroundColor(.primary)
                    }
                    Text(item.message ??  "")
                        .font(.system(size: FontSize.standard))
                        .foregroundColor(Color.vpieGrayWithDarkMode)
                }
                
                if item.id != vm.scanHistory.last?.id {
                    Line()
                        .stroke(.vpieGrayWithDarkMode.opacity(0.5),
                                style: StrokeStyle(lineWidth: 1, dash: [2]))
                        .frame(height: 0.5)
                }
            }
        }
        
    }
    
    private var updateButton: some View {
        BorderedButton(
            title: "update_inventory",
            titleColor: .appWhite,
            backgroundColor: Color.appBlack,
            borderColor: .appWhite,
            cornerRadius: AppCornerRadius.button,
            verticalPadding: AppPadding.extraSmall
            
        ) {}.disabled(vm.isLoading)
    }
    
    private var cameraScanButton: some View {
        BorderedButton(
            title: "scan_barcode_camera",
            titleColor: Color.appBlack,
            alignment: Alignment.leading,
            backgroundColor: .appWhite,
            borderColor: Color.buttonBackground,
            cornerRadius: AppCornerRadius.button,
            verticalPadding: AppPadding.small,
            image: Image(systemName: "camera.fill")
        ) {
            Task { await vm.scanExternal() }
        }
    }
    
    
    private var externalScanButton: some View {
        BorderedButton(
            title: "scan_barcode_device",
            titleColor: Color.appBlack,
            alignment: Alignment.leading,
            backgroundColor: .appWhite,
            borderColor: Color.buttonBackground,
            cornerRadius: AppCornerRadius.button,
            verticalPadding: AppPadding.small,
            image: Image(systemName: "barcode.viewfinder")
        ) {
            Task { await vm.scanExternal() }
        }
    }
}

struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

#Preview {
    InventoryView(vm: InventoryViewModel(service: InventoryService()))
}
