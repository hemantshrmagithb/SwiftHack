import SwiftUI

struct InsightRow: View {
    let insight: KitchenInsight
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(insight.iconColor.opacity(0.1))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: insight.iconSystemName)
                        .foregroundColor(insight.iconColor)
                        .font(.body)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(insight.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                
                Text(insight.description)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
                    .lineLimit(nil)
            }
        }
        .padding(.vertical, 12)
    }
}
