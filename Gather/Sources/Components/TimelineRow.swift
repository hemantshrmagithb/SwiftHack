import SwiftUI

struct TimelineRow: View {
    let event: TimelineEvent
    let isLast: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Timeline line and dot
            VStack {
                Circle()
                    .fill(Color.blinkZoGreen)
                    .frame(width: 8, height: 8)
                    .padding(.top, 4)
                
                if !isLast {
                    Rectangle()
                        .fill(Color.blinkZoGreen)
                        .frame(width: 2)
                }
            }
            .frame(width: 20)
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(event.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                    Spacer()
                    Text(event.timeString)
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
                
                Text(event.description)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
                    .lineLimit(2)
            }
            .padding(.bottom, 24)
        }
    }
}
