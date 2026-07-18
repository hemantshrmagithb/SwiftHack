import SwiftUI

struct CheckoutConfirmationView: View {
    var onDismiss: () -> Void
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.gatherGreen.opacity(0.1))
                    .frame(width: 140, height: 140)
                    .scaleEffect(animate ? 1.2 : 0.8)
                    .opacity(animate ? 0 : 1)
                
                Circle()
                    .fill(Color.gatherGreen)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color(UIColor.systemBackground))
            }
            
            VStack(spacing: 12) {
                Text("Your Kitchen Is Ready")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primaryText)
                
                Text("Your smart restock has been processed successfully.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondaryText)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: onDismiss) {
                    Text("Continue Shopping")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.primaryText)
                        .cornerRadius(16)
                }
                
                Button(action: onDismiss) {
                    Text("Back to Home")
                        .font(.headline)
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.cardBackground)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.easeOut(duration: 1.5).repeatForever(autoreverses: false)) {
                animate = true
            }
        }
    }
}
