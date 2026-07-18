import SwiftUI

struct ChecklistCategoryCard: View {
    let category: ChecklistCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: category.iconName)
                .font(.system(size: 20))
                .foregroundColor(.primaryText)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(category.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                
                Text("\(category.itemCount) items")
                    .font(.caption2)
                    .foregroundColor(.secondaryText)
            }
            
            Spacer()
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.appBackground)
                        .frame(height: 4)
                        .cornerRadius(2)
                    
                    Rectangle()
                        .fill(category.progress == 1.0 ? Color.gatherGreen : Color.primaryText)
                        .frame(width: geometry.size.width * CGFloat(category.progress), height: 4)
                        .cornerRadius(2)
                }
            }
            .frame(height: 4)
        }
        .padding(16)
        .background(Color.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        )
    }
}
