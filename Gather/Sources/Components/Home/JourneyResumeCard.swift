import SwiftUI

struct JourneyResumeCard: View {
    let journey: JourneyProgress
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Continue Your Journey")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primaryText)
            
            HStack(spacing: 16) {
                Circle()
                    .fill(Color.appBackground)
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: journey.iconSystemName)
                            .foregroundColor(.primaryText)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(journey.title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                    
                    Text(journey.progressText)
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
                
                Spacer()
                
                Circle()
                    .fill(Color.black)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "arrow.right")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    )
            }
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.appBackground)
                        .frame(height: 4)
                    
                    Capsule()
                        .fill(Color.blinkZoGreen)
                        .frame(width: geometry.size.width * journey.progressPercentage, height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(24)
        .background(Color.cardBackground)
        .cornerRadius(32)
    }
}
