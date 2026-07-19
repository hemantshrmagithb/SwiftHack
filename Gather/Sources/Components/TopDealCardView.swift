import SwiftUI

struct TopDealCardView: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("TOP\nDEALS")
                .font(.headline)
                .foregroundColor(.blinkZoPink)
            
            HStack(alignment: .lastTextBaseline) {
                Text("₹\(product.currentPrice)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blinkZoPink)
                    .cornerRadius(6)
                
                if let original = product.originalPrice {
                    Text("₹\(original)")
                        .font(.caption)
                        .strikethrough()
                        .foregroundColor(.secondaryText)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
            }
            
            Text(product.name)
                .font(.headline)
                .fontWeight(.bold)
            
            Image(systemName: product.imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .foregroundColor(.primaryText)
                .padding(.top, 8)
                .padding(.bottom, 16)
        }
        .padding(16)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
