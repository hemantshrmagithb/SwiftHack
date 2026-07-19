import Foundation

struct TimelineEvent: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let title: String
    let description: String
    let timeString: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, timeString
    }
}

struct ChecklistItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let task: String
    let isEssential: Bool
    
    enum CodingKeys: String, CodingKey {
        case task, isEssential
    }
}

struct ShoppingProduct: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let name: String
    let estimatedQuantity: String
    let estimatedPrice: Double
    let isEssential: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, estimatedQuantity, estimatedPrice, isEssential
    }
}

struct ShoppingCategory: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let name: String
    let iconName: String
    let products: [ShoppingProduct]
    
    enum CodingKeys: String, CodingKey {
        case name, iconName, products
    }
}

struct PlanSummary: Codable, Hashable {
    let foodStrategy: String
    let drinkStrategy: String
    let dessertRecommendation: String
    let wasteReductionTip: String
}

struct AIReasoningItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let trigger: String
    let result: String
    
    enum CodingKeys: String, CodingKey {
        case trigger, result
    }
}

struct OccasionPlan: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let summary: PlanSummary
    let timeline: [TimelineEvent]
    let checklist: [ChecklistItem]
    let shoppingCategories: [ShoppingCategory]
    let totalEstimatedBudget: Double
    let warnings: [String]
    let premiumUpgrades: [String]
    let aiReasoning: [AIReasoningItem]
    
    enum CodingKeys: String, CodingKey {
        case title, summary, timeline, checklist, shoppingCategories, totalEstimatedBudget, warnings, premiumUpgrades, aiReasoning
    }
}
