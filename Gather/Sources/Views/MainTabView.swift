import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            OccasionPlannerCoordinator()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("Occasion")
                }
                .tag(1)
            
            ExpenseCoordinator()
                .tabItem {
                    Image(systemName: "indianrupeesign.circle")
                    Text("Splitter")
                }
                .tag(2)
            
            SmartFridgeCoordinator(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "refrigerator")
                    Text("Fridge")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(.gatherPink)
    }
}

#Preview {
    MainTabView()
}
