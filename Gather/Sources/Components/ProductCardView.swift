import SwiftUI

struct ProductCardView: View {
    var product: Product
    
    var body: some View {
        VStack(spacing: 8) {
            if let tag = product.discountTag {
                Text(tag)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gatherPink.opacity(0.8))
                    .cornerRadius(4)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding([.top, .trailing], 8)
            }
            
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
            
            Image(systemName: product.imageSystemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
