import SwiftUI

struct HomeCommandHeaderView: View {
    let name: String
    let address: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Good Morning,")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                
                HStack(spacing: 4) {
                    Text(name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                    Text("👋")
                        .font(.title2)
                }
                
                HStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                        Text("12 Mins")
                    }
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.cardBackground)
                    .cornerRadius(12)
                    
                    HStack(spacing: 4) {
                        Text(address)
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                            .lineLimit(1)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundColor(.secondaryText)
                    }
                }
                .padding(.top, 4)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                CircleButton(icon: "wallet.pass")
                CircleButton(icon: "bell")
            }
        }
    }
}

struct CircleButton: View {
    let icon: String
    var body: some View {
        Button(action: {}) {
            Circle()
                .fill(Color.cardBackground)
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.primaryText)
                )
        }
    }
}
