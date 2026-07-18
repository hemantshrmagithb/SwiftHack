import SwiftUI

struct QuickActionsRow: View {
    let actions: [QuickAction]
    let onActionTap: (QuickAction) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                Spacer().frame(width: 8)
                
                ForEach(actions) { action in
                    Button(action: {
                        onActionTap(action)
                    }) {
                        VStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.cardBackground)
                                    .frame(width: 64, height: 64)
                                    .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                                
                                Image(systemName: action.iconSystemName)
                                    .font(.title2)
                                    .foregroundColor(.primaryText)
                            }
                            
                            Text(action.title)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primaryText)
                        }
                        .frame(width: 80)
                    }
                }
                
                Spacer().frame(width: 8)
            }
        }
    }
}
