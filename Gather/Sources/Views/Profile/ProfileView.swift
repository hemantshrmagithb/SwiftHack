import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let user = viewModel.user,
                          let health = viewModel.healthData,
                          let household = viewModel.householdData {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 32) {
                            
                            ProfileHeaderView(user: user)
                            
                            HealthZoneCard(healthData: health)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Smart Insights")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primaryText)
                                    .padding(.horizontal, 24)
                                
                                SmartInsightsGrid(insights: viewModel.smartInsights)
                                    .padding(.horizontal, 24)
                            }
                            
                            BlinkZoDNACard(traits: viewModel.dnaTraits)
                            
                            MyFamilyCard(householdData: household)
                            
                            SettingsSection(orderHistory: viewModel.orderHistory)
                            
                            Spacer().frame(height: 100)
                        }
                        .padding(.vertical, 24)
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ProfileView()
}
