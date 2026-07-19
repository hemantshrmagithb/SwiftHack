import SwiftUI

struct AIReasoningCardView: View {
    let reasoningItems: [AIReasoningItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundColor(.blinkZoPink)
                Text("AI Reasoning")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
            
            Text("Why these recommendations were generated:")
                .font(.subheadline)
                .foregroundColor(.secondaryText)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(reasoningItems) { item in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "arrow.turn.down.right")
                            .foregroundColor(.blinkZoPink)
                            .font(.subheadline)
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.trigger)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.primaryText)
                            
                            Text(item.result)
                                .font(.caption)
                                .foregroundColor(.secondaryText)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding()
                    .background(Color.appBackground)
                    .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 10, y: 5)
    }
}
