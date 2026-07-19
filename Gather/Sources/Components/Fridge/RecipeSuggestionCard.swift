import SwiftUI

struct RecipeSuggestionCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image Placeholder
            ZStack(alignment: .topTrailing) {
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(height: 160)
                    .overlay(
                        Image(systemName: "fork.knife")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
                
                Text(recipe.prepTime)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
                    .padding(12)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(recipe.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .top, spacing: 6) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.blinkZoGreen)
                            .font(.caption)
                            .padding(.top, 2)
                        Text(recipe.availableIngredients.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.secondaryText)
                            .lineLimit(2)
                    }
                    
                    HStack(alignment: .top, spacing: 6) {
                        Image(systemName: "circle")
                            .foregroundColor(.secondaryText)
                            .font(.caption)
                            .padding(.top, 2)
                        
                        let missingText = recipe.missingIngredients.joined(separator: ", ")
                        Text("Missing: \\(missingText)")
                            .font(.subheadline)
                            .foregroundColor(.secondaryText)
                            .lineLimit(2)
                    }
                }
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                        Text("Add Missing Item")
                            .fontWeight(.bold)
                    }
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.primaryText)
                    .cornerRadius(12)
                }
                .padding(.top, 8)
            }
            .padding(16)
        }
        .frame(width: 280)
        .background(Color.cardBackground)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}
