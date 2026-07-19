import SwiftUI

struct PlanningAnimationView: View {
    var viewModel: PlanningViewModel
    
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            // Faint glowing animation rings
            ZStack {
                Circle()
                    .stroke(Color.blinkZoPink.opacity(0.1), lineWidth: 40)
                    .frame(width: 250, height: 250)
                    .scaleEffect(scale)
                    .opacity(opacity)
                
                Circle()
                    .stroke(Color.blinkZoGreen.opacity(0.05), lineWidth: 60)
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
            
            VStack(spacing: 24) {
                Image(systemName: "sparkle.magnifyingglass")
                    .font(.system(size: 40))
                    .foregroundColor(.blinkZoPink)
                
                VStack(spacing: 8) {
                    Text("AI is Reasoning")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primaryText)
                    
                    Text(viewModel.currentReasoningState)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondaryText)
                        .transition(.opacity)
                        .animation(.easeInOut, value: viewModel.currentReasoningState)
                }
            }
            .padding(.horizontal, 40)
        }
        .navigationBarHidden(true)
    }
}
