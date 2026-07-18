import SwiftUI

struct SettlementRow: View {
    let settlement: Settlement
    
    var body: some View {
        HStack(spacing: 16) {
            MemberAvatar(member: settlement.member, size: 44)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(settlement.member.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                
                let typeStr = settlement.type == .paid ? "Paid" : "Owes"
                let amountStr = String(format: "%.2f", settlement.amount)
                Text("\(typeStr) $\(amountStr)")
                    .font(.caption)
                    .foregroundColor(.secondaryText)
            }
            
            Spacer()
            
            if settlement.isSettled {
                Text("Settled")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(.secondaryText)
                    .cornerRadius(20)
            } else {
                Button(action: {}) {
                    Text("Settle")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.primaryText)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(20)
                }
            }
        }
        .padding(.vertical, 12)
    }
}
