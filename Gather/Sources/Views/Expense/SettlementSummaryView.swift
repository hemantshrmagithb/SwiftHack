import SwiftUI

struct SettlementSummaryView: View {
    @Bindable var viewModel: ExpenseViewModel
    var onDismiss: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let recommendation = viewModel.splitRecommendation {
                VStack(alignment: .center, spacing: 24) {
                    
                    VStack(spacing: 12) {
                        Text("The Fair Split")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primaryText)
                        
                        Text("Here is the breakdown of your latest gathering.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondaryText)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 24)
                    
                    // Total and Remaining
                    HStack(spacing: 16) {
                        VStack(spacing: 8) {
                            Text("TOTAL")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.primaryText)
                            Text(String(format: "₹%.2f", recommendation.totalAmount))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primaryText)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(Color.cardBackground)
                        .cornerRadius(24)
                        
                        VStack(spacing: 8) {
                            Text("REMAINING")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.primaryText)
                            Text(String(format: "₹%.2f", recommendation.remainingAmount))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.red) // Assuming red for remaining
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                        .background(Color.cardBackground)
                        .cornerRadius(24)
                    }
                    .padding(.horizontal, 24)
                    
                    // Split Logic
                    HStack(alignment: .top, spacing: 16) {
                        Image(systemName: "sparkles")
                            .font(.title3)
                            .foregroundColor(.primaryText)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Split Logic")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.primaryText)
                            
                            Text(recommendation.splitLogic)
                                .font(.subheadline)
                                .foregroundColor(.secondaryText)
                                .lineLimit(nil)
                        }
                    }
                    .padding(24)
                    .background(Color.cardBackground)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    
                    // Settlements
                    VStack(spacing: 16) {
                        ForEach(recommendation.settlements) { settlement in
                            SettlementRow(settlement: settlement)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 8)
                                .background(Color.cardBackground)
                                .cornerRadius(24)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 120)
                }
            } else {
                Text("Error generating split.")
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .overlay(
            VStack(spacing: 12) {
                Spacer()
                Button(action: {
                    viewModel.currentStep = .shoppingRoom
                }) {
                    Text("Continue Shopping")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.gatherGreen)
                        .cornerRadius(12)
                }
                
                Button(action: onDismiss) {
                    Text("Back to Home")
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
            .padding(.bottom, 16)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.appBackground.opacity(0), Color.appBackground]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 150)
            )
            , alignment: .bottom
        )
    }
}
