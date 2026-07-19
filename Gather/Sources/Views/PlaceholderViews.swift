import SwiftUI

struct PlaceholderView: View {
    let title: String
    let iconSystemName: String
    let description: String
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: iconSystemName)
                    .font(.system(size: 80))
                    .foregroundColor(.blinkZoPink)
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Coming Soon")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.black)
                    .cornerRadius(20)
                    .padding(.top, 16)
            }
            .padding()
        }
    }
}

struct OccasionView: View {
    var body: some View {
        PlaceholderView(
            title: "Occasion Planner",
            iconSystemName: "party.popper.fill",
            description: "Plan your celebrations effortlessly with AI assistance."
        )
    }
}

struct ExpenseSplitterView: View {
    var body: some View {
        PlaceholderView(
            title: "Expense Splitter",
            iconSystemName: "indianrupeesign.circle.fill",
            description: "Easily split expenses with friends and track who owes whom."
        )
    }
}

struct FridgeView: View {
    var body: some View {
        PlaceholderView(
            title: "AI Fridge",
            iconSystemName: "refrigerator.fill",
            description: "Manage your inventory, get recipes, and reduce food waste."
        )
    }
}


