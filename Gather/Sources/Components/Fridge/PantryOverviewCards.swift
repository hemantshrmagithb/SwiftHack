import SwiftUI

struct FreshItemsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Fresh Items")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                    Text("12 items perfectly ripe.")
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                }
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle")
                    Text("Optimal")
                        .fontWeight(.medium)
                }
                .font(.caption)
                .foregroundColor(.green)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
            }
            
            // Image and Button
            VStack {
                // We'll use a placeholder colored circle if image fails, but try to use the uploaded tomato image or SF symbol
                Image(systemName: "leaf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .foregroundColor(.blinkZoGreen)
                    .padding()
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Log Fresh Produce")
                            .fontWeight(.bold)
                    }
                    .font(.caption)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.primaryText)
                    .cornerRadius(20)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(24)
        .background(Color.blinkZoGreen.opacity(0.05))
        .cornerRadius(24)
    }
}

struct ExpiringSoonCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                    Text("Expiring Soon")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                }
                Text("3 items need attention.")
                    .font(.subheadline)
                    .foregroundColor(.secondaryText)
            }
            
            VStack(spacing: 8) {
                HStack {
                    Text("Organic Milk")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    Text("2 days")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(UIColor.systemBackground).opacity(0.7))
                .cornerRadius(12)
                
                HStack {
                    Text("Spinach")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    Text("Tomorrow")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(UIColor.systemBackground).opacity(0.7))
                .cornerRadius(12)
            }
        }
        .padding(24)
        .background(Color.blinkZoLightPink)
        .cornerRadius(24)
    }
}

struct RunningLowCard: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.systemBackground))
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "basket")
                        .font(.largeTitle)
                        .foregroundColor(.primaryText)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Running Low")
                    .font(.headline)
                    .foregroundColor(.primaryText)
                Text("Stock up on essentials.")
                    .font(.subheadline)
                    .foregroundColor(.secondaryText)
                    .lineLimit(2)
            }
            Spacer()
            
            Button(action: {}) {
                Text("View List (5)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(.primaryText)
                    .cornerRadius(16)
            }
        }
        .padding(20)
        .background(Color.cardBackground)
        .cornerRadius(24)
    }
}
