import SwiftUI

struct ShoppingListRow: View {
    let item: ShoppingItem
    let toggleAction: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: toggleAction) {
                Image(systemName: item.isChecked ? "checkmark.square.fill" : "square")
                    .font(.title2)
                    .foregroundColor(item.isChecked ? .gray : .primaryText)
            }
            
            Text(item.name)
                .font(.body)
                .strikethrough(item.isChecked)
                .foregroundColor(item.isChecked ? .gray : .primaryText)
            
            Spacer()
            
            if let claimer = item.claimedBy {
                HStack(spacing: 4) {
                    Text(claimer.name.split(separator: " ").first ?? "")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                    MemberAvatar(member: claimer, size: 20)
                }
            }
        }
        .padding(.vertical, 12)
    }
}
