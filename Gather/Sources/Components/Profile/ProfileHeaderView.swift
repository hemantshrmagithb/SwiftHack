import SwiftUI

struct ProfileHeaderView: View {
    let user: ProfileUser
    
    var body: some View {
        VStack(spacing: 16) {
            // Profile Image (using SF Symbol as placeholder for real image)
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray.opacity(0.5))
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                
                // Settings icon overlay
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 14))
                    .foregroundColor(.primaryText)
                    .padding(6)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 5, y: 2)
                    .offset(x: 0, y: 0)
            }
            .padding(.top, 24)
            
            VStack(spacing: 4) {
                Text(user.name)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primaryText)
                
                Text("Member since \\(String(user.memberSince))")
                    .font(.subheadline)
                    .foregroundColor(.secondaryText)
            }
            
            HStack(spacing: 12) {
                if user.hasBlinkZoPlus {
                    HStack(spacing: 6) {
                        Image(systemName: "star.circle.fill")
                        Text("BlinkZo Plus")
                            .fontWeight(.medium)
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.primaryText)
                    .cornerRadius(20)
                }
                
                HStack(spacing: 6) {
                    Image(systemName: "heart.circle")
                    Text("Score: \\(user.healthyLivingScore)")
                        .fontWeight(.medium)
                }
                .font(.caption)
                .foregroundColor(.blinkZoGreen)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.blinkZoGreen.opacity(0.1))
                .cornerRadius(20)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 24)
    }
}
