import SwiftUI

struct MyFamilyCard: View {
    let householdData: HouseholdData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "house.fill")
                        .foregroundColor(.gatherPink)
                    Text("My Family & Home")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                }
                Spacer()
            }
            
            // Family Members
            VStack(alignment: .leading, spacing: 16) {
                Text("Household Members")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondaryText)
                
                HStack(spacing: -12) {
                    ForEach(householdData.members) { member in
                        Image(systemName: member.avatarName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.cardBackground, lineWidth: 2))
                    }
                    
                    Button(action: {}) {
                        Circle()
                            .fill(Color.appBackground)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "plus")
                                    .foregroundColor(.primaryText)
                            )
                            .overlay(Circle().stroke(Color.cardBackground, lineWidth: 2))
                    }
                }
            }
            
            Divider()
            
            // Household Details Grid
            VStack(spacing: 16) {
                HStack {
                    detailView(title: "Household Size", value: "\\(householdData.householdSize) People", icon: "person.2")
                    detailView(title: "Kitchen Size", value: householdData.kitchenSize, icon: "stove")
                }
                HStack {
                    detailView(title: "Monthly Budget", value: "₹\\(Int(householdData.monthlyBudget))", icon: "indianrupeesign")
                    detailView(title: "Delivery Window", value: householdData.deliveryWindow, icon: "box.truck")
                }
            }
        }
        .padding(24)
        .background(Color.cardBackground)
        .cornerRadius(32)
    }
    
    private func detailView(title: String, value: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.secondaryText)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primaryText)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
