import SwiftUI

struct AnimatedReasoningView: View {
    let stages = [
        "Understanding purchase history...",
        "Estimating household consumption...",
        "Detecting products running low...",
        "Finding recipe opportunities...",
        "Reducing food waste...",
        "Preparing shopping recommendations..."
    ]
    
    @State private var stageIndex: Int = 0
    @State private var progress: CGFloat = 0.0
    let totalDuration: Double = 4.0 // matches the simulated delay in service
    
    var body: some View {
        VStack(spacing: 32) {
            ZStack {
                Circle()
                    .fill(Color.primaryText.opacity(0.05))
                    .frame(width: 120, height: 120)
                
                Circle()
                    .stroke(Color.primaryText.opacity(0.1), lineWidth: 1)
                    .frame(width: 140, height: 140)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 40))
                    .foregroundColor(.primaryText)
                    .rotationEffect(.degrees(progress * 360))
            }
            .padding(.bottom, 16)
            
            VStack(spacing: 12) {
                Text("Analyzing your pantry...")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primaryText)
                
                Text(stages[stageIndex])
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondaryText)
                    .id(stageIndex)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 4)
                        .cornerRadius(2)
                    
                    Rectangle()
                        .fill(Color.primaryText)
                        .frame(width: geometry.size.width * progress, height: 4)
                        .cornerRadius(2)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 60)
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        let stageDuration = totalDuration / Double(stages.count)
        
        withAnimation(.linear(duration: totalDuration)) {
            progress = 1.0
        }
        
        for i in 0..<stages.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + (stageDuration * Double(i))) {
                withAnimation {
                    stageIndex = i
                }
            }
        }
    }
}
