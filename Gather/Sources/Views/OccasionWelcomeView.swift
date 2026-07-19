import SwiftUI

struct OccasionWelcomeView: View {
    var viewModel: PlanningViewModel
    var onDismiss: () -> Void
    
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
            // We use a beautiful combination of shapes and SF Symbols to create a premium feel
            ZStack {
                Circle()
                    .fill(Color.blinkZoLightPink)
                    .frame(width: 250, height: 250)
                
                Image(systemName: "gift.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blinkZoPink)
                    .shadow(color: Color.blinkZoPink.opacity(0.3), radius: 15, x: 0, y: 10)
                
                // Confetti
                ForEach(0..<10) { i in
                    Circle()
                        .fill(i % 2 == 0 ? Color.blinkZoGreen : Color.yellow)
                        .frame(width: 8, height: 8)
                        .offset(x: CGFloat.random(in: -100...100), y: CGFloat.random(in: -100...100))
                }
            }
            .padding(.bottom, 40)
            
            Text("Let's plan your\nnext celebration.")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.primaryText)
                .padding(.bottom, 16)
            
            Text("From picking the perfect menu to building the guest list, your AI event concierge will handle the details.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondaryText)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                viewModel.path.append(.selection)
            }) {
                Text("Start Planning")
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blinkZoGreen)
                    .cornerRadius(30)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}
