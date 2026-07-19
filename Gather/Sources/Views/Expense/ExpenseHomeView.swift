import SwiftUI

struct ExpenseHomeView: View {
    var viewModel: ExpenseViewModel
    var onDismiss: () -> Void
    @State private var showJoinAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: onDismiss) {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.primaryText)
                }
                Spacer()
            }
            .padding()
            
            Spacer()
            
            // Premium Illustration Placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.cardBackground)
                    .frame(width: 300, height: 260)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                
                // Group of avatars mock
                HStack(spacing: -10) {
                    Circle().fill(Color.red).frame(width: 40, height: 40)
                    Circle().fill(Color.blue).frame(width: 50, height: 50).offset(y: -10)
                    Circle().fill(Color.orange).frame(width: 60, height: 60).offset(y: -20)
                    Circle().fill(Color.green).frame(width: 50, height: 50).offset(y: -10)
                    Circle().fill(Color.purple).frame(width: 40, height: 40)
                }
            }
            .padding(.bottom, 40)
            
            Text("Split Together")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.primaryText)
                .padding(.bottom, 8)
            
            Text("Shop together. Pay fairly.")
                .font(.body)
                .foregroundColor(.secondaryText)
                .padding(.bottom, 40)
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: {
                    withAnimation(.spring) {
                        viewModel.nextStep()
                    }
                }) {
                    Text("Create Group")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.gatherGreen)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    showJoinAlert = true
                }) {
                    Text("Join Existing Group")
                        .font(.headline)
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.cardBackground)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .alert("Join Group", isPresented: $showJoinAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Share your invite link with friends to join your group. They can scan the QR code or click the link to join.")
        }
    }
}
