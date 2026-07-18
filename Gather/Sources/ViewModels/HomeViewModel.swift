import Foundation
import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var searchText: String = ""
    
    // Command Center Data
    var insight: AIInsight?
    var quickActions: [QuickAction] = []
    var currentJourney: JourneyProgress?
    var recommendations: [Recommendation] = []
    
    var isLoading: Bool = false
    
    init() {
        loadData()
    }
    
    func loadData() {
        isLoading = true
        
        Task {
            try? await Task.sleep(nanoseconds: 800_000_000)
            
            await MainActor.run {
                self.insight = AIInsight(
                    text: "You're hosting dinner tomorrow. Your pantry already contains pasta and olive oil. Only 5 ingredients are needed.",
                    ctaTitle: "CONTINUE PLANNING",
                    iconName: "leaf.arrow.triangle.circlepath"
                )
                
                self.quickActions = [
                    QuickAction(title: "Planner", iconSystemName: "calendar", targetTab: 1),
                    QuickAction(title: "Smart Fridge", iconSystemName: "refrigerator", targetTab: 3),
                    QuickAction(title: "Split Together", iconSystemName: "person.2", targetTab: 2),
                    QuickAction(title: "Favorites", iconSystemName: "heart", targetTab: nil)
                ]
                
                self.currentJourney = JourneyProgress(
                    title: "Resume Birthday Planning",
                    progressText: "2/5 Steps Completed",
                    progressPercentage: 0.4,
                    iconSystemName: "birthday.cake"
                )
                
                self.recommendations = [
                    Recommendation(title: "Seasonal Groceries", iconSystemName: "carrot", color: .orange),
                    Recommendation(title: "Healthy Picks", iconSystemName: "apple.logo", color: .red) // Using apple.logo as placeholder for apples/groceries
                ]
                
                self.isLoading = false
            }
        }
    }
}
