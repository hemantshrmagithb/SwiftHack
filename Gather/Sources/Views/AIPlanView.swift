import SwiftUI

struct AIPlanView: View {
    var viewModel: PlanningViewModel
    var onDismiss: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if let plan = viewModel.plan {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Header
                    VStack(alignment: .center, spacing: 12) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("AI Generated Plan Ready")
                        }
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.primaryText.opacity(0.05))
                        .cornerRadius(12)
                        
                        Text(plan.title)
                            .font(.system(size: 32, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primaryText)
                        
                        Text("We've crafted a seamless timeline and optimized checklist for your occasion.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondaryText)
                            .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                    
                    // Strategy Summary
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Strategy")
                            .font(.headline)
                            .padding(.horizontal, 24)
                        
                        VStack(spacing: 12) {
                            StrategyRow(icon: "fork.knife", title: "Food", description: plan.summary.foodStrategy)
                            StrategyRow(icon: "wineglass", title: "Drinks", description: plan.summary.drinkStrategy)
                            StrategyRow(icon: "birthday.cake", title: "Desserts", description: plan.summary.dessertRecommendation)
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    // Event Timeline
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "clock")
                            Text("Event Timeline")
                                .font(.headline)
                            Spacer()
                        }
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 24)
                        
                        VStack(spacing: 0) {
                            ForEach(Array(plan.timeline.enumerated()), id: \.element.id) { index, event in
                                TimelineRow(event: event, isLast: index == plan.timeline.count - 1)
                            }
                        }
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                    }
                    
                    // AI Reasoning
                    AIReasoningCardView(reasoningItems: plan.aiReasoning)
                        .padding(.horizontal)
                    
                    // Shopping Categories
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Shopping List")
                            .font(.headline)
                            .padding(.horizontal, 24)
                        
                        ForEach(plan.shoppingCategories) { category in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: category.iconName)
                                    Text(category.name)
                                        .font(.subheadline).bold()
                                    Spacer()
                                    Text("\\(category.products.count) items")
                                        .font(.caption)
                                        .foregroundColor(.secondaryText)
                                }
                                .padding(.bottom, 4)
                                
                                ForEach(category.products) { product in
                                    HStack {
                                        Text(product.name)
                                            .font(.subheadline)
                                        Spacer()
                                        Text(product.estimatedQuantity)
                                            .font(.caption)
                                            .foregroundColor(.secondaryText)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                            .padding(16)
                            .background(Color.cardBackground)
                            .cornerRadius(16)
                            .padding(.horizontal, 24)
                        }
                    }
                    
                    // Action Checklist
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Action Checklist")
                            .font(.headline)
                            .padding(.horizontal, 24)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(plan.checklist) { item in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: item.isEssential ? "exclamationmark.circle.fill" : "circle")
                                        .foregroundColor(item.isEssential ? .blinkZoOrange : .secondaryText)
                                    Text(item.task)
                                        .font(.subheadline)
                                    Spacer()
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                    }
                    
                    // Premium Upgrades
                    if !plan.premiumUpgrades.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Premium Upgrades")
                                .font(.headline)
                                .padding(.horizontal, 24)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(plan.premiumUpgrades, id: \.self) { upgrade in
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text(upgrade)
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                }
                            }
                            .padding(16)
                            .background(Color.cardBackground)
                            .cornerRadius(16)
                            .padding(.horizontal, 24)
                        }
                    }
                    
                    // Warnings & Tips
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(plan.warnings, id: \.self) { warning in
                            HStack(alignment: .top, spacing: 16) {
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundColor(.blinkZoOrange)
                                Text(warning)
                                    .font(.subheadline)
                                Spacer()
                            }
                            .padding(16)
                            .background(Color.cardBackground)
                            .cornerRadius(16)
                        }
                        
                        HStack(alignment: .top, spacing: 16) {
                            Image(systemName: "leaf")
                                .foregroundColor(.blinkZoGreen)
                            Text(plan.summary.wasteReductionTip)
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 24)
                    
                    // Budget Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("ESTIMATED BUDGET")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        Text(String(format: "₹%.2f", plan.totalEstimatedBudget))
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(Color(UIColor.systemBackground))
                        
                        Divider().background(Color.gray.opacity(0.5))
                        
                        HStack {
                            Text("This is an AI estimation. Actual cart total may vary.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(24)
                    .background(Color.primaryText)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                    
                    Spacer().frame(height: 100)
                }
                .padding(.top, 16)
            } else {
                Text("Error generating plan.")
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .overlay(
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Button(action: {
                        // Go back to event details (pop animation + planReady)
                        while viewModel.path.last != .details && !viewModel.path.isEmpty {
                            viewModel.path.removeLast()
                        }
                    }) {
                        Image(systemName: "pencil")
                            .font(.headline)
                            .foregroundColor(.primaryText)
                            .frame(width: 50, height: 50)
                            .background(Color.cardBackground)
                            .cornerRadius(25)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    
                    Button(action: {
                        viewModel.path.append(.cartSummary)
                    }) {
                        Text("Create My Cart")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blinkZoGreen)
                            .cornerRadius(30)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.appBackground.opacity(0), Color.appBackground]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 120)
                )
            }
            , alignment: .bottom
        )
        .navigationBarHidden(true)
    }
}

struct StrategyRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .frame(width: 24, height: 24)
                .foregroundColor(.primaryText)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
            }
            Spacer()
        }
        .padding(16)
        .background(Color.cardBackground)
        .cornerRadius(12)
    }
}

