import SwiftUI

struct RestockItemRow: View {
    let item: RestockItem
    let isCheckboxStyle: Bool
    let toggleAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 48, height: 48)
                .overlay(
                    Image(systemName: item.iconSystemName)
                        .foregroundColor(.primaryText)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primaryText)
                
                Text(item.quantity)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
            }
            
            Spacer()
            
            if isCheckboxStyle {
                Button(action: toggleAction) {
                    Image(systemName: item.isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundColor(item.isSelected ? .primaryText : .gray.opacity(0.3))
                }
            } else {
                Text(item.quantity)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
            }
        }
        .padding(.vertical, 12)
    }
}
