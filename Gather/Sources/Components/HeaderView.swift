import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Good Morning, Alex")
                    .font(.body)
                    .foregroundColor(.secondaryText)
                
                Text("13 minutes")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack(spacing: 4) {
                    Text("123 Apple Way, Cupertino")
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                    Image(systemName: "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                // Wallet button
                VStack(spacing: 2) {
                    Image(systemName: "banknote.fill")
                        .foregroundColor(.blinkZoGreen)
                        .font(.system(size: 20))
                    Text("₹0")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .padding(8)
                .background(Circle().fill(Color.cardBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                // Profile image
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .overlay(Circle().stroke(Color.cardBackground, lineWidth: 2))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            }
        }
    }
}
