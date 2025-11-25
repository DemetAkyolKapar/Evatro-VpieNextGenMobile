import SwiftUI

struct ActionRow: View {
    let title: LocalizedStringKey
    let systemImage: String
    var destination: AnyView? = nil
    var useAccentBackground: Bool = false
    var action: (() -> Void)? = nil
    var backgroundColor: Color = Color(.secondarySystemBackground)
    
    var body: some View {
        Group {
            if let action {
                Button(action: action) {
                    rowContent
                }
                .buttonStyle(.plain)
                
            } else if let destination {
                NavigationLink(destination: destination) {
                    rowContent
                }
                .buttonStyle(.plain)
                .buttonBorderShape(.roundedRectangle)
            } else {
                rowContent
            }
        }
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(useAccentBackground ? Color.accentColor.opacity(0.08) : backgroundColor)
        )
    }
    
    private var rowContent: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundColor(.vpieGray)
                .font(.system(size: FontSize.xlarge))
                .frame(width: 24)
            
            Text(title)
                .font(.system(size: FontSize.standard, weight: .medium))
                .foregroundColor(.vpieGray)
            
            Spacer()
        }
    }
}


#Preview {
    VStack(spacing: 8) {
        ActionRow(title: "Profile", systemImage: "person.fill", destination: AnyView(Text("Profile View")), backgroundColor: .appWhite)
        ActionRow(title: "Sync Info", systemImage: "info.circle.fill", destination: AnyView(Text("Sync Information")), backgroundColor: .appWhite)
    }
    .padding()
}
