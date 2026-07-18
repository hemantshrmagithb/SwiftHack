import SwiftUI

struct MemberAvatar: View {
    let member: Member
    var size: CGFloat = 32
    
    var body: some View {
        Group {
            if let imageName = member.avatarImageName {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.gray)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } else {
                Text(member.initial)
                    .font(.system(size: size * 0.4, weight: .bold))
                    .foregroundColor(Color.primaryText)
                    .frame(width: size, height: size)
                    .background(Color.appBackground)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            }
        }
    }
}
