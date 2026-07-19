import SwiftUI

struct AISplitAnalysisView: View {
    @Bindable var viewModel: ExpenseViewModel
    @State private var progress: CGFloat = 0.0
    @State private var stageIndex: Int = 0
    
    let stages = [
        "Analyzing shared items...",
        "Applying discounts...",
        "Considering personal purchases...",
        "Balancing contributions...",
        "Optimizing fairness..."
    ]
    
    var body: some View {
        ZStack {
            Color.appBackground.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                
                // Animated Sparkle Icon
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
                }
                .padding(.bottom, 16)
                
                VStack(spacing: 12) {
                    Text("Finding the fairest\nsplit...")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primaryText)
                    
                    Text("Considering individual items, shared essentials, and dietary preferences.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondaryText)
                        .padding(.horizontal, 40)
                }
                
                // Progress Bar and Stage Text
                VStack(spacing: 16) {
                    Text(stages[stageIndex])
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryText)
                        .id(stageIndex)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 4)
                                .cornerRadius(2)
                            
                            Rectangle()
                                .fill(Color.blinkZoGreen)
                                .frame(width: geometry.size.width * progress, height: 4)
                                .cornerRadius(2)
                        }
                    }
                    .frame(height: 4)
                    .padding(.horizontal, 60)
                }
                .padding(.top, 24)
                
                Spacer().frame(height: 100)
                
                Button(action: {
                    viewModel.previousStep()
                }) {
                    Text("Cancel calculation")
                        .font(.subheadline)
                        .foregroundColor(.secondaryText)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        let totalDuration = 3.5 // Must match the delay in SplitCalculationService
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
