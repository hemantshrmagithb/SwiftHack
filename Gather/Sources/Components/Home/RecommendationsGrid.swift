import SwiftUI

struct RecommendationsGrid: View {
    let recommendations: [Recommendation]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Smart Recommendations")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                
                Text("FOUNDATION MODELS GENERATED")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.secondaryText)
                    .kerning(1.2)
            }
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(recommendations) { rec in
                    VStack(spacing: 16) {
                        // Image Placeholder (Using rounded rect with SF symbol to mimic the 3D look)
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                                .aspectRatio(1, contentMode: .fit)
                                .padding(12)
                            
                            Image(systemName: rec.iconSystemName)
                                .font(.system(size: 60))
                                .foregroundColor(rec.color)
                        }
                        
                        Text(rec.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 8)
                    }
                    .background(Color.cardBackground)
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                    )
                }
            }
        }
    }
}
