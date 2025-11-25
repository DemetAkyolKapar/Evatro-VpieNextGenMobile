// filepath: VpieNextGen/Account/AccountView.swift
import SwiftUI

struct AccountView: View {
    @StateObject  var viewModel: AccountViewModel
    @Environment(\.deviceBehavior) private var deviceBehavior
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            ScrollView {
              
                    VStack(spacing: AppSpacing.standard) {
                        profileHeader
                        VStack(alignment: .center,spacing: AppSpacing.standard) {
                            Text("Tap to update your photo")
                                .font(.system(size: FontSize.thin))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.vpieGrayWithDarkMode)
                                .dynamicTypeSize(.xSmall ... .accessibility5)
                            SkyFloatingTextField(placeholder: "Full name", text: $viewModel.nameSurname, textFieldType: .textField)
                            
                            BorderedButton(
                                title: "Update profile",
                                titleColor: .appWhite,
                                backgroundColor: Color.appBlack,
                                borderColor: .appWhite,
                                cornerRadius: AppCornerRadius.button,
                                verticalPadding: AppPadding.extraSmall) {
                            }
                        }
                    }.cardStyle()
                    
                    VStack(alignment: .leading,spacing: AppSpacing.standard) {
                        Text("Change password")
                            .font(.system(size: FontSize.large, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.appBlack)
                            .dynamicTypeSize(.xSmall ... .accessibility5)
                            .padding(.top, AppPadding.large)
                        VStack(alignment: .center,spacing: AppSpacing.standard) {
                            
                            SkyFloatingTextField(placeholder: "Password", text: $viewModel.password, textFieldType: .secureField)
                            SkyFloatingTextField(placeholder: "New password", text: $viewModel.newPassword, textFieldType: .secureField)
                            SkyFloatingTextField(placeholder: "Confirm password", text: $viewModel.newPassword, textFieldType: .secureField)
                            BorderedButton(
                                title: "Change",
                                titleColor: .appWhite,
                                backgroundColor: Color.appBlack,
                                borderColor: .appWhite,
                                cornerRadius: AppCornerRadius.button,
                                verticalPadding: AppPadding.extraSmall

                            ) {
                            }
                        }
                    }.cardStyle()
                    .padding(.top, AppPadding.large)

                Button(action: { viewModel.deleteUser() }) {
                    HStack(spacing: AppSpacing.standard) {
                        
                        Text("delete_user")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(colorScheme == .light ? .errorDark :
                                    .errorMain)
                            .dynamicTypeSize(.xSmall ... .accessibility5)
                            .padding(AppPadding.medium)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color(.systemRed))
                    .background(
                        RoundedRectangle(cornerRadius: AppCornerRadius.standard)
                            .fill(colorScheme == .light ? .errorBackground :
                                .errorLight)
                    )
                }
                .buttonStyle(.plain)
                .cardStyle()
                .padding(.top, AppPadding.large)
            
            }
            .padding(AppPadding.medium)
        }
    }
}


private var profileHeader: some View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let isCompact = sizeClass == .compact
    let circleSize: CGFloat = isCompact ? 100 : 140
    let imageSize = circleSize * 0.87
    
    return VStack(spacing: AppSpacing.standard) {
        ZStack {
            Circle()
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.green, .cyan, .green]),
                        center: .center
                    ),
                    lineWidth: AppLineWidth.thick
                )
                .frame(width: circleSize, height: circleSize)
            
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: imageSize, height: imageSize)
                .clipShape(Circle())
        }
    }
    .frame(maxWidth: .infinity)
}


#Preview {
    AccountView(viewModel :  AccountViewModel(service: AccountService()))
}
