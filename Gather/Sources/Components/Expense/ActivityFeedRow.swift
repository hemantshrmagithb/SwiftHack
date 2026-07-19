import SwiftUI

struct ActivityFeedRow: View {
    let event: ActivityEvent
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            MemberAvatar(member: event.member, size: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text(event.member.name.split(separator: " ").first ?? "")
                        .fontWeight(.bold)
                    Text(event.action)
                    Text(event.target)
                        .fontWeight(.bold)
                }
                .font(.subheadline)
                .foregroundColor(.primaryText)
                
                if event.action == "is looking at" {
                    // Typing indicator animation could go here, for now static dots
                    HStack(spacing: 2) {
                        Circle().fill(Color.blinkZoGreen).frame(width: 6, height: 6)
                        Circle().fill(Color.blinkZoGreen).frame(width: 6, height: 6)
                        Circle().fill(Color.blinkZoGreen).frame(width: 6, height: 6)
                    }
                    .padding(.top, 2)
                } else {
                    Text(event.timeAgo)
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
