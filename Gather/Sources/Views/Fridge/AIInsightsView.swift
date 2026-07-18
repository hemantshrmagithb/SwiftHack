import SwiftUI

struct AIInsightsView: View {
    @Bindable var viewModel: SmartFridgeViewModel
    var isReasoning: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                if isReasoning {
                    AnimatedReasoningView()
                        .padding(.top, 60)
                } else {
                    // Smart Insights Header & List
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("Smart Insights")
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 24)
                        
                        VStack(spacing: 0) {
                            ForEach(viewModel.insights) { insight in
                                InsightRow(insight: insight)
                                if insight.id != viewModel.insights.last?.id {
                                    Divider()
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.cardBackground)
                        .cornerRadius(24)
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 16)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    
                    // Recipe Suggestions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recipe Suggestions")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                            .padding(.horizontal, 24)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                Spacer().frame(width: 8)
                                ForEach(viewModel.recipes) { recipe in
                                    RecipeSuggestionCard(recipe: recipe)
                                }
                                Spacer().frame(width: 8)
                            }
                        }
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                
                Spacer().frame(height: 120)
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .overlay(
            VStack {
                Spacer()
                if !isReasoning {
                    Button(action: {
                        withAnimation {
                            viewModel.nextStep()
                        }
                    }) {
                        Text("Review Restock List")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.primaryText)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.appBackground.opacity(0), Color.appBackground]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 100)
                            .offset(y: 16)
                    )
                }
            }
        )
    }
}
