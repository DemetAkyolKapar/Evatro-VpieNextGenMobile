import SwiftUI

struct FloatingSubtitleRow: View {
    var label: String
    @Binding var text: String
    var image: Image
    var imageColor: Color = Color.vpieGray

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.vpieGrayWithDarkMode, lineWidth: 0.3)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.cardBackground))
            HStack(alignment: .top, spacing: AppPadding.medium) {
                Button(action: {}) {
                    Text(text)
                        .foregroundColor(Color.appBlack)
                        .font(.system(size: FontSize.standard  ))
                }
                Spacer()
                Button {  } label: {
                    image
                        .foregroundColor(imageColor)
                        .frame(alignment: .trailing)
                }
            }
            .padding(.horizontal, 12)
            Text(label)
                .foregroundColor(Color.vpieGrayWithDarkMode)
                .background(Color.cardBackground)
                .offset(y: -24)
                .font(.system(size: FontSize.standard  ))
                .animation(.easeInOut(duration: 0.2), value: true)
                .padding(.horizontal, 12)
        }
        .frame(height: 50)
    }
}
