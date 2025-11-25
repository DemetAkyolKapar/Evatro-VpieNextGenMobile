import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            ScrollView {
                VStack(spacing: AppSpacing.standard) {
                    profileHeader
                    VStack(spacing: 8) {
                        ActionRow(title: "Account settings", systemImage: "gearshape.fill", backgroundColor: Color(.appWhite))

                        ActionRow(title: "Change tenant", systemImage: "person.2.fill", backgroundColor:.appWhite)
                        
                        ActionRow(title: "sync_now", systemImage: "arrow.triangle.2.circlepath", backgroundColor: .appWhite)
                        
                        ActionRow(title: "Sync info", systemImage: "info.circle.fill", backgroundColor: .appWhite)

                        ActionRow(title: "send_diagnostics", systemImage: "paperplane.fill", backgroundColor: .appWhite)
                        
                        ActionRow(title: "App info", systemImage: "person.fill", backgroundColor: .appWhite)
                    }
                    
                    bottomButtons
                }.padding(8)
            }.cardStyle()
                .padding()
                .scrollIndicators(.hidden)
                .navigationTitle("")
        }
    }
    
    private var profileHeader: some View {
        @Environment(\.horizontalSizeClass) var sizeClass
        
        let isCompact = sizeClass == .compact
        let circleSize: CGFloat = isCompact ? 100 : 140
        let imageSize = circleSize * 0.87
        
        return VStack(spacing: 12) {
            ZStack {
                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.green, .cyan, .green]),
                            center: .center
                        ),
                        lineWidth: 3
                    )
                    .frame(width: circleSize, height: circleSize)
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(Circle())
            }
            Text("Sheldon Harrison")
                .font(.system(size: FontSize.large, weight: .semibold))
                .dynamicTypeSize(.xSmall ... .accessibility5)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
    }
    
    private var bottomButtons: some View {
        VStack(spacing: 1) {
            
            HStack(spacing: 12) {
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "cloud.moon.fill")
                            .font(.system(size: FontSize.large))
                            .dynamicTypeSize(.xSmall ... .accessibility5)
                            .foregroundColor(Color(.systemGray))
                        Spacer()
                        Toggle("", isOn: .constant(false))
                            .labelsHidden()
                    }
                    Text("Mode")
                        .font(.system(size: FontSize.standard, weight: .semibold))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                    
                        .foregroundColor(.appBlack)
                        .padding(.top, AppPadding.extraSmall)
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 90)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.cardBackground)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(.vpieGray.opacity(0.12))
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(vm.versionText)
                        .font(.system(size: FontSize.standard, weight: .semibold))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .foregroundColor(.appBlack)
                    
                    Text("Last Full Sync:   10/31/25, 11:32 AM")
                        .font(.system(size: FontSize.thin))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                        .foregroundColor(.appBlack)
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 90)
                .background(
                    RoundedRectangle(cornerRadius: AppCornerRadius.standard)
                        .fill(Color("BackgroundNeutral"))
                )
            }
            .frame(maxWidth: .infinity)
            
            Button(action: { vm.logout() }) {
                HStack(spacing: 15) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                    
                    Text("logout")
                        .font(.system(size: FontSize.large, weight: .bold))
                        .dynamicTypeSize(.xSmall ... .accessibility5)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, AppPadding.medium)
                .foregroundColor(colorScheme == .light ?  .errorDark : .errorMain)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.errorBackground)
                )
            }
            .buttonStyle(.plain)
            .padding(.top, AppPadding.large)
        }
    }
}

#Preview {
    SettingsView()
}
