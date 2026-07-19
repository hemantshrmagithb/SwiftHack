import SwiftUI

struct CheckoutSummaryView: View {
    var viewModel: SmartFridgeViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 24) {
                
                VStack(spacing: 8) {
                    Text("Checkout")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primaryText)
                    
                    Text("Here is the final summary of your items.")
                        .font(.body)
                        .foregroundColor(.secondaryText)
                }
                .padding(.top, 24)
                
                if let summary = viewModel.checkoutSummary {
                    VStack(alignment: .leading, spacing: 24) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("AI Summary")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.primaryText)
                        
                        // Summary Rows
                        VStack(spacing: 20) {
                            HStack {
                                Text("Estimated Budget")
                                    .foregroundColor(.secondaryText)
                                Spacer()
                                Text(String(format: "₹%.2f", summary.estimatedBudget))
                                    .fontWeight(.bold)
                            }
                            Divider()
                            
                            HStack {
                                Text("Items Added")
                                    .foregroundColor(.secondaryText)
                                Spacer()
                                Text("\\(summary.itemsAddedCount) Items")
                                    .fontWeight(.bold)
                            }
                            Divider()
                            
                            HStack {
                                Text("Already Available")
                                    .foregroundColor(.secondaryText)
                                Spacer()
                                HStack {
                                    Text("\\(summary.alreadyAvailableCount) Items")
                                        .fontWeight(.bold)
                                    Text("In Fridge")
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(Capsule())
                                }
                            }
                            Divider()
                            
                            HStack {
                                Text("Suggested Savings")
                                    .foregroundColor(.secondaryText)
                                Spacer()
                                Text(String(format: "-₹%.2f", abs(summary.suggestedSavings)))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gatherGreen)
                            }
                            Divider()
                            
                            HStack {
                                Image(systemName: "box.truck")
                                    .foregroundColor(.secondaryText)
                                Text("Delivery Time")
                                    .foregroundColor(.secondaryText)
                                Spacer()
                                Text(summary.deliveryTime)
                                    .fontWeight(.bold)
                            }
                        }
                        .font(.body)
                        
                        Button(action: {
                            withAnimation {
                                viewModel.nextStep()
                            }
                        }) {
                            HStack {
                                Text("Proceed to Checkout")
                                Image(systemName: "arrow.right")
                            }
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.primaryText)
                            .cornerRadius(16)
                        }
                        .padding(.top, 16)
                        
                        Text("Secure checkout via Apple Pay")
                            .font(.caption)
                            .foregroundColor(.secondaryText)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    .padding(24)
                    .background(Color.cardBackground)
                    .cornerRadius(32)
                    .padding(.horizontal, 24)
                } else {
                    ProgressView()
                        .padding(.top, 40)
                }
                
                Spacer()
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}
