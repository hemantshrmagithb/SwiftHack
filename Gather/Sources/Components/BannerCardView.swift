import SwiftUI

struct BannerCardView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("BIG")
                .font(Typography.title3)
                .fontWeight(.light)
                .foregroundColor(.gatherPink)
            
            Text("Beauty Bash")
                .font(Typography.promoHeader)
                .foregroundColor(.gatherPink)
            
            Text("17th-19th JULY")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.gatherPink)
                .cornerRadius(12)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.gatherLightPink)
        .cornerRadius(16)
    }
}

struct InformationCardView: View {
    var text: String
    var iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.red) // Generic color for the lipstick icon mockup
            Text(text)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.cardBackground)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}
