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
                        
                        Text("Everything is set.")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primaryText)
                        
                        Text("We've crafted a seamless timeline and optimized checklist for your occasion. Review the details below.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondaryText)
                            .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                    
                    // Event Timeline
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "clock")
                            Text("Event Timeline")
                                .font(.headline)
                            Spacer()
                            Text("Sat, Aug 12") // Ideally formatted from viewModel.eventDate
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.appBackground)
                                .cornerRadius(8)
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
                    
                    // Optimized Checklist
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Optimized Checklist")
                                .font(.headline)
                                .foregroundColor(.primaryText)
                            Spacer()
                            Image(systemName: "line.3.horizontal.decrease")
                                .foregroundColor(.secondaryText)
                        }
                        .padding(.horizontal, 24)
                        
                        let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(plan.checklist) { category in
                                ChecklistCategoryCard(category: category)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    // Image Placeholder
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gatherLightPink)
                        .frame(height: 200)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 40))
                                .foregroundColor(.gatherPink.opacity(0.5))
                        )
                        .padding(.horizontal, 24)
                    
                    // Budget Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("TOTAL ESTIMATED BUDGET")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        Text(String(format: "$%.2f", plan.totalBudget))
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(Color(UIColor.systemBackground))
                        
                        Divider().background(Color.gray.opacity(0.5))
                        
                        HStack {
                            Text("Groceries")
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "$%.2f", plan.groceriesBudget))
                                .foregroundColor(Color(UIColor.systemBackground))
                        }
                        .font(.subheadline)
                        
                        HStack {
                            Text("Decor & Supplies")
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "$%.2f", plan.decorBudget))
                                .foregroundColor(Color(UIColor.systemBackground))
                        }
                        .font(.subheadline)
                        
                        HStack {
                            Text("Buffer (10%)")
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "$%.2f", plan.bufferBudget))
                                .foregroundColor(Color(UIColor.systemBackground))
                        }
                        .font(.subheadline)
                    }
                    .padding(24)
                    .background(Color.primaryText)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                    
                    // Waste Reduction Tip
                    HStack(alignment: .top, spacing: 16) {
                        Image(systemName: "leaf")
                            .font(.system(size: 20))
                            .foregroundColor(.gatherGreen)
                            .padding(10)
                            .background(Color.gatherGreen.opacity(0.1))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Waste Reduction Tip")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.primaryText)
                            Text(plan.wasteReductionTip)
                                .font(.caption)
                                .foregroundColor(.secondaryText)
                                .lineLimit(nil)
                        }
                    }
                    .padding(16)
                    .background(Color.cardBackground)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)
                    
                    // Recommended Combos
                    HStack(alignment: .top, spacing: 16) {
                        Image(systemName: "link")
                            .font(.system(size: 20))
                            .foregroundColor(.primaryText)
                            .padding(10)
                            .background(Color.appBackground)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Recommended Combos")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.primaryText)
                            Text(plan.recommendedCombo)
                                .font(.caption)
                                .foregroundColor(.secondaryText)
                                .lineLimit(nil)
                        }
                    }
                    .padding(16)
                    .background(Color.cardBackground)
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
                        viewModel.previousStep()
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
                        onDismiss() // For now just dismiss
                    }) {
                        Text("Create My Cart")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.gatherGreen)
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
