import SwiftUI

struct AIInsightCardView: View {
    let insight: AIInsight
    var onCTATap: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top, spacing: 12) {
                // Animated AI Icon (using SF symbol and gradient for effect)
                ZStack {
                    Circle()
                        .fill(Color.blinkZoGreen.opacity(0.1))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: insight.iconName)
                        .font(.title3)
                        .foregroundColor(.blinkZoGreen)
                }
                
                Text(insight.text)
                    .font(.subheadline)
                    .foregroundColor(.primaryText)
                    .lineSpacing(4)
            }
            
            Button(action: {
                onCTATap?()
            }) {
                Text(insight.ctaTitle)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blinkZoGreen)
                    .cornerRadius(12)
            }
        }
        .padding(24)
        // Light glassmorphism effect
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.cardBackground, Color.blinkZoGreen.opacity(0.05)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(32)
    }
}
