import SwiftUI

struct PantryOverviewView: View {
    @Bindable var viewModel: SmartFridgeViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pantry Overview")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primaryText)
                    
                    Text("Manage your inventory and plan your next occasion with ease.")
                        .font(.body)
                        .foregroundColor(.secondaryText)
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                // Cards
                VStack(spacing: 16) {
                    FreshItemsCard()
                    ExpiringSoonCard()
                    RunningLowCard()
                }
                .padding(.horizontal, 24)
                
                // Recently Added
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Recently Added")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(.primaryText)
                    }
                    .padding(.horizontal, 24)
                    
                    VStack(spacing: 0) {
                        ForEach(viewModel.recentlyAdded) { item in
                            HStack(spacing: 16) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 48, height: 48)
                                    .overlay(
                                        Image(systemName: item.iconSystemName)
                                            .foregroundColor(.primaryText)
                                    )
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.name)
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.primaryText)
                                    Text(item.quantityInfo)
                                        .font(.caption)
                                        .foregroundColor(.secondaryText)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 12)
                            
                            if item.id != viewModel.recentlyAdded.last?.id {
                                Divider().padding(.leading, 64)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color.cardBackground)
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                }
                
                // Restocked This Week
                VStack(alignment: .leading, spacing: 16) {
                    Text("Restocked This Week")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 24)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            Spacer().frame(width: 8)
                            ForEach(viewModel.restockedThisWeek) { item in
                                VStack(spacing: 12) {
                                    Circle()
                                        .fill(Color.primaryText)
                                        .frame(width: 56, height: 56)
                                        .overlay(
                                            Image(systemName: item.iconSystemName)
                                                .foregroundColor(Color(UIColor.systemBackground))
                                        )
                                    
                                    VStack(spacing: 2) {
                                        Text(item.name)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                            .foregroundColor(.primaryText)
                                        Text(item.quantityInfo)
                                            .font(.caption)
                                            .foregroundColor(.secondaryText)
                                    }
                                }
                                .frame(width: 120, height: 160)
                                .background(Color.cardBackground)
                                .cornerRadius(24)
                            }
                            Spacer().frame(width: 8)
                        }
                    }
                }
                
                Spacer().frame(height: 120)
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        viewModel.nextStep()
                    }
                }) {
                    HStack {
                        Image(systemName: "sparkles")
                        Text("Analyze Pantry")
                    }
                    .font(.headline)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.primaryText)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, y: 5)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.appBackground.opacity(0), Color.appBackground]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 100)
                        .offset(y: 16)
                )
            }
        )
    }
}
