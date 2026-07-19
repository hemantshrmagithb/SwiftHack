import SwiftUI

struct SmartFridgeWelcomeView: View {
    var viewModel: SmartFridgeViewModel
    var onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Placeholder for premium kitchen illustration (Image 5 from mockups)
            ZStack(alignment: .topLeading) {
                Color.cardBackground
                    .edgesIgnoringSafeArea(.top)
                
                // This would be replaced by the actual kitchen image, using a placeholder gradient for now
                LinearGradient(gradient: Gradient(colors: [Color.gatherGreen.opacity(0.2), Color.gatherLightPink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.top)
                    .frame(maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 16) {
                    Button(action: onDismiss) {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.primaryText)
                            .padding()
                            .background(Color(UIColor.systemBackground).opacity(0.8))
                            .clipShape(Circle())
                    }
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome\nback to your\nSmart Fridge.")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.primaryText)
                            .lineSpacing(4)
                        
                        Text("Your groceries, organized\nintelligently.")
                            .font(.title3)
                            .foregroundColor(.secondaryText)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                Button(action: {
                    withAnimation(.spring) {
                        viewModel.nextStep()
                    }
                }) {
                    HStack {
                        Text("Open My Fridge")
                        Image(systemName: "arrow.right")
                    }
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Color.primaryText)
                    .cornerRadius(16)
                }
            }
            .padding(24)
            .background(Color.appBackground)
        }
        .navigationBarHidden(true)
    }
}
