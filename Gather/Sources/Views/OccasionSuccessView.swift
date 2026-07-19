import SwiftUI

struct OccasionSuccessView: View {
    var viewModel: PlanningViewModel
    var onDismiss: () -> Void
    
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.gatherPink.opacity(0.1))
                    .frame(width: 140, height: 140)
                    .scaleEffect(animate ? 1.2 : 0.8)
                    .opacity(animate ? 0 : 1)
                
                Circle()
                    .fill(Color.gatherPink)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "party.popper.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(UIColor.systemBackground))
            }
            
            VStack(spacing: 12) {
                Text("Order Placed!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primaryText)
                
                Text("Your occasion supplies will be delivered soon. Get ready to celebrate!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondaryText)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                    viewModel.resetFlow()
                    onDismiss()
                }) {
                    Text("Back to Occasions")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.primaryText)
                        .cornerRadius(16)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .onAppear {
            // Success haptic
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            withAnimation(.easeOut(duration: 1.5).repeatForever(autoreverses: false)) {
                animate = true
            }
        }
    }
}
