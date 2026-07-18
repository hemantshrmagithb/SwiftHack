import SwiftUI

struct CategoryRowView: View {
    var categories: [Category]
    var onSelect: (Category) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(categories) { category in
                    VStack(spacing: 8) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: category.iconSystemName)
                                .font(.system(size: 24))
                                .foregroundColor(category.isSelected ? .primaryText : .secondaryText)
                                .frame(width: 50, height: 50)
                                .background(category.isSelected ? Color.black.opacity(0.05) : Color.clear)
                                .clipShape(Circle())
                            
                            if category.isNew {
                                Text("New")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(Color.gatherPink)
                                    .cornerRadius(4)
                                    .offset(x: 10, y: -5)
                            }
                        }
                        
                        Text(category.name)
                            .font(.caption)
                            .fontWeight(category.isSelected ? .bold : .regular)
                            .foregroundColor(category.isSelected ? .primaryText : .secondaryText)
                        
                        if category.isSelected {
                            Rectangle()
                                .fill(Color.primaryText)
                                .frame(height: 2)
                                .padding(.horizontal, 8)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        onSelect(category)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
