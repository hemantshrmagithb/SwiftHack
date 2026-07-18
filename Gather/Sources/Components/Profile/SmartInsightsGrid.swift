import SwiftUI

struct SmartInsightsGrid: View {
    let insights: [ProfileInsight]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(insights) { insight in
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: insight.iconSystemName)
                            .font(.title3)
                            .foregroundColor(insight.isCurrency ? .primaryText : .gatherGreen)
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(insight.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primaryText)
                        
                        Text(insight.subtitle)
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                            .lineLimit(3)
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.cardBackground)
                .cornerRadius(24)
            }
        }
    }
}
