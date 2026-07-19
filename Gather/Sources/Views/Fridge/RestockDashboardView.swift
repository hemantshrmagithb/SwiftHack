import SwiftUI

struct RestockDashboardView: View {
    @Bindable var viewModel: SmartFridgeViewModel
    @State private var showCustomizeAlert = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("One Tap Restock")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primaryText)
                    
                    Text("Your essential items, intelligently curated for a seamless restock. Review your lists and replenish with a single tap.")
                        .font(.body)
                        .foregroundColor(.secondaryText)
                }
                .padding(.horizontal, 24)
                
                // CTAs
                VStack(spacing: 12) {
                    Button(action: {
                        withAnimation {
                            viewModel.nextStep()
                        }
                    }) {
                        HStack {
                            Image(systemName: "cart.fill")
                            Text("Restock Everything")
                        }
                        .font(.headline)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.primaryText)
                        .cornerRadius(16)
                    }
                    
                    Button(action: {
                        showCustomizeAlert = true
                    }) {
                        HStack {
                            Image(systemName: "pencil")
                            Text("Customize List")
                        }
                        .font(.headline)
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.appBackground)
                        .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 24)
                
                // Frequently Purchased Grid
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "heart")
                        Text("Frequently Purchased")
                        Spacer()
                        Text("12 Items")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.appBackground)
                            .clipShape(Capsule())
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                    .padding(.horizontal, 24)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.frequentlyPurchased) { item in
                            VStack(spacing: 12) {
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image(systemName: item.iconSystemName)
                                            .foregroundColor(.primaryText)
                                            .font(.title2)
                                    )
                                
                                VStack(spacing: 4) {
                                    Text(item.name)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primaryText)
                                    Text(item.quantity)
                                        .font(.caption)
                                        .foregroundColor(.secondaryText)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 24)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.vertical, 24)
                .background(Color.cardBackground)
                .cornerRadius(32)
                .padding(.horizontal, 16)
                
                // Weekly Essentials
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Weekly")
                        Spacer()
                        Text("8 Items")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.appBackground)
                            .clipShape(Capsule())
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                    
                    VStack(spacing: 0) {
                        ForEach(viewModel.weeklyEssentials) { item in
                            RestockItemRow(item: item, isCheckboxStyle: true) {
                                viewModel.toggleWeeklyEssential(item)
                            }
                            if item.id != viewModel.weeklyEssentials.last?.id {
                                Divider()
                            }
                        }
                    }
                    
                    Button(action: {
                        // Select all weekly essentials
                        for item in viewModel.weeklyEssentials {
                            if !item.isSelected {
                                viewModel.toggleWeeklyEssential(item)
                            }
                        }
                    }) {
                        Text("VIEW ALL WEEKLY")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                }
                .padding(24)
                .background(Color.cardBackground)
                .cornerRadius(32)
                .padding(.horizontal, 16)
                
                // Monthly Essentials
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "calendar.badge.clock")
                        Text("Monthly")
                        Spacer()
                        Text("5 Items")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.appBackground)
                            .clipShape(Capsule())
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                    
                    VStack(spacing: 0) {
                        ForEach(viewModel.monthlyEssentials) { item in
                            RestockItemRow(item: item, isCheckboxStyle: true) {
                                viewModel.toggleMonthlyEssential(item)
                            }
                            if item.id != viewModel.monthlyEssentials.last?.id {
                                Divider()
                            }
                        }
                    }
                    
                    Button(action: {
                        // Select all monthly essentials
                        for item in viewModel.monthlyEssentials {
                            if !item.isSelected {
                                viewModel.toggleMonthlyEssential(item)
                            }
                        }
                    }) {
                        Text("VIEW ALL MONTHLY")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                }
                .padding(24)
                .background(Color.cardBackground)
                .cornerRadius(32)
                .padding(.horizontal, 16)
                
                Spacer().frame(height: 40)
            }
            .padding(.top, 16)
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .alert("Customize List", isPresented: $showCustomizeAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Use the checkboxes in the Weekly and Monthly sections to customize which items to include in your restock order.")
        }
    }
}
