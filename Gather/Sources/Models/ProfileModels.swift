import Foundation
import SwiftUI

// MARK: - User Model
struct ProfileUser: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String // "person.crop.circle" or actual image
    let memberSince: Int
    let hasBlinkZoPlus: Bool
    let healthyLivingScore: Int
}

// MARK: - Health & Diet Model
struct HealthDietData {
    let proteinCurrent: Int
    let proteinGoal: Int
    let fruitVegCurrent: Int
    let fruitVegGoal: Int
    let isVegetarian: Bool
    let isVegan: Bool
    let isGlutenFree: Bool
    let overallRating: String
    
    var proteinProgress: Double {
        return Double(proteinCurrent) / Double(proteinGoal)
    }
    
    var fruitVegProgress: Double {
        return Double(fruitVegCurrent) / Double(fruitVegGoal)
    }
}

// MARK: - Household Model
struct HouseholdData {
    let address: String
    let householdSize: Int
    let kitchenSize: String
    let monthlyBudget: Double
    let shoppingFrequency: String
    let deliveryWindow: String
    
    let members: [FamilyMember]
}

struct FamilyMember: Identifiable {
    let id = UUID()
    let name: String
    let type: MemberType
    let avatarName: String
    
    enum MemberType: String {
        case child = "Child"
        case parent = "Parent"
        case roommate = "Roommate"
        case partner = "Partner"
    }
}

// MARK: - BlinkZo DNA Model
struct BlinkZoDNA: Identifiable {
    let id = UUID()
    let title: String
    let iconSystemName: String
    let color: Color
}

// MARK: - Smart Insight Model
struct ProfileInsight: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconSystemName: String
    let isCurrency: Bool
}

// MARK: - Order History Item
struct OrderHistoryItem: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let amount: Double?
    let type: OrderType
    
    enum OrderType: String {
        case occasion = "Occasion"
        case splitGroup = "Split Group"
        case restock = "Fridge Restock"
        case normal = "Normal Order"
        
        var iconName: String {
            switch self {
            case .occasion: return "party.popper"
            case .splitGroup: return "indianrupeesign.circle"
            case .restock: return "refrigerator"
            case .normal: return "bag"
            }
        }
        
        var color: Color {
            switch self {
            case .occasion: return Color.purple
            case .splitGroup: return Color.blue
            case .restock: return Color.green
            case .normal: return Color.blinkZoPink
            }
        }
    }
}
