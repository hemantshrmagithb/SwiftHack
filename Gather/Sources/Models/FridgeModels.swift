import Foundation
import SwiftUI

// MARK: - Pantry Models

struct PantryItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: PantryCategory
    let status: PantryStatus
    let dateAdded: Date
    let expiryDate: Date?
    let iconSystemName: String
    let quantityInfo: String
    
    enum PantryCategory: String {
        case fresh = "Fresh"
        case dairy = "Dairy"
        case pantry = "Pantry"
        case frozen = "Frozen"
    }
    
    enum PantryStatus: String {
        case optimal = "Optimal"
        case expiringSoon = "Expiring Soon"
        case runningLow = "Running Low"
    }
}

// MARK: - AI Insight Models

struct KitchenInsight: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let iconSystemName: String
    let type: InsightType
    
    enum InsightType {
        case warning // red
        case info // neutral/gray
        case success // green
    }
    
    var iconColor: Color {
        switch type {
        case .warning: return Color.red
        case .info: return Color.gray
        case .success: return Color.green
        }
    }
}

// MARK: - Recipe Models

struct Recipe: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let prepTime: String
    let availableIngredients: [String]
    let missingIngredients: [String]
    let difficulty: String
}

// MARK: - Restock Models

struct RestockItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let quantity: String
    let iconSystemName: String
    var isSelected: Bool = true
}

struct ShoppingBundle: Identifiable {
    let id = UUID()
    let title: String
    let items: [RestockItem]
    let type: BundleType
    
    enum BundleType {
        case frequent
        case weekly
        case monthly
    }
}

// MARK: - Checkout Models

struct CheckoutSummary: Identifiable {
    let id = UUID()
    let estimatedBudget: Double
    let itemsAddedCount: Int
    let alreadyAvailableCount: Int
    let suggestedSavings: Double
    let deliveryTime: String
    let wasteReductionScore: Int
}
