import Foundation

struct TimelineEvent: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let timeString: String
}

struct ChecklistCategory: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let iconName: String
    let itemCount: Int
    let progress: Double // 0.0 to 1.0
}

struct CelebrationPlan {
    let id = UUID()
    let title: String
    let timeline: [TimelineEvent]
    let checklist: [ChecklistCategory]
    
    let totalBudget: Double
    let groceriesBudget: Double
    let decorBudget: Double
    let bufferBudget: Double
    
    let wasteReductionTip: String
    let recommendedCombo: String
}
