import SwiftUI

struct PlanningAnimationView: View {
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            // Faint glowing animation rings
            ZStack {
                Circle()
                    .stroke(Color.gatherPink.opacity(0.1), lineWidth: 40)
                    .frame(width: 250, height: 250)
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                Circle()
                    .stroke(Color.gatherGreen.opacity(0.05), lineWidth: 60)
                    .frame(width: 350, height: 350)
                    .scaleEffect(scale * 1.2)
                    .opacity(opacity * 0.8)
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    scale = 1.2
                    opacity = 0.1
                }
            }
            
            VStack(spacing: 16) {
                Text("Creating your celebration\\nplan...")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primaryText)
                
                Text("Gathering fresh ingredients and\\nparty essentials...")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondaryText)
            }
            .padding(.horizontal, 40)
        }
        .navigationBarHidden(true)
    }
}
