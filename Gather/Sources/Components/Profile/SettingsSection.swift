import SwiftUI

struct SettingsSection: View {
    let orderHistory: [OrderHistoryItem]
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Order History (Preview)
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Recent Orders")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                    Spacer()
                    Button(action: {}) {
                        Text("View All")
                            .font(.subheadline)
                            .foregroundColor(.gatherPink)
                    }
                }
                .padding(.horizontal, 24)
                
                VStack(spacing: 0) {
                    ForEach(orderHistory.prefix(3)) { order in
                        HStack(spacing: 16) {
                            Circle()
                                .fill(order.type.color.opacity(0.1))
                                .frame(width: 48, height: 48)
                                .overlay(
                                    Image(systemName: order.type.iconName)
                                        .foregroundColor(order.type.color)
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(order.title)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primaryText)
                                Text(order.date)
                                    .font(.caption)
                                    .foregroundColor(.secondaryText)
                            }
                            
                            Spacer()
                            
                            if let amount = order.amount {
                                Text("₹\\(Int(amount))")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primaryText)
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        
                        if order.id != orderHistory.prefix(3).last?.id {
                            Divider().padding(.leading, 80)
                        }
                    }
                }
                .background(Color.cardBackground)
                .cornerRadius(24)
                .padding(.horizontal, 24)
            }
            
            // Settings Links
            VStack(spacing: 0) {
                settingsLink(title: "Favorites", icon: "heart", color: .gatherPink)
                Divider().padding(.leading, 56)
                settingsLink(title: "Connected Devices", icon: "applewatch", color: .primaryText)
                Divider().padding(.leading, 56)
                settingsLink(title: "Privacy & Data", icon: "lock.shield", color: .blue)
                Divider().padding(.leading, 56)
                settingsLink(title: "App Settings", icon: "gearshape", color: .gray)
            }
            .background(Color.cardBackground)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            
            // Sign Out
            Button(action: {}) {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.cardBackground)
                    .cornerRadius(16)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
    }
    
    private func settingsLink(title: String, icon: String, color: Color) -> some View {
        Button(action: {}) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.body)
                    .foregroundColor(color)
                    .frame(width: 24)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primaryText)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondaryText)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
        }
    }
}
