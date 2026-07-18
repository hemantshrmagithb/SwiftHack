import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 32) {
                            // Header
                            HomeCommandHeaderView(
                                name: "Arpita",
                                address: "Chhatarpur Farms..."
                            )
                            .padding(.horizontal)
                            .padding(.top, 8)
                            
                            // Smart Search
                            SmartSearchInputView(text: $viewModel.searchText)
                                .padding(.horizontal)
                            
                            // AI Insight of the Day
                            if let insight = viewModel.insight {
                                AIInsightCardView(insight: insight)
                                    .padding(.horizontal)
                            }
                            
                            // Quick Actions
                            QuickActionsRow(actions: viewModel.quickActions) { action in
                                if let target = action.targetTab {
                                    selectedTab = target
                                }
                            }
                            
                            // Continue Journey
                            if let journey = viewModel.currentJourney {
                                JourneyResumeCard(journey: journey)
                                    .padding(.horizontal)
                            }
                            
                            // Smart Recommendations
                            RecommendationsGrid(recommendations: viewModel.recommendations)
                                .padding(.horizontal)
                            
                            // Extra space at bottom for tab bar
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                }
            }
        }
    }
}

