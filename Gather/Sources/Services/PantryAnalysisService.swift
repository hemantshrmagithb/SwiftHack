import Foundation

class PantryAnalysisService {
    
    func getFreshItems() -> [PantryItem] {
        return [
            PantryItem(name: "Tomatoes", category: .fresh, status: .optimal, dateAdded: Date(), expiryDate: Date().addingTimeInterval(86400 * 5), iconSystemName: "leaf", quantityInfo: "12 items perfectly ripe")
        ]
    }
    
    func getExpiringSoonItems() -> [PantryItem] {
        return [
            PantryItem(name: "Organic Milk", category: .dairy, status: .expiringSoon, dateAdded: Date().addingTimeInterval(-86400 * 5), expiryDate: Date().addingTimeInterval(86400 * 2), iconSystemName: "drop", quantityInfo: "2 days"),
            PantryItem(name: "Spinach", category: .fresh, status: .expiringSoon, dateAdded: Date().addingTimeInterval(-86400 * 4), expiryDate: Date().addingTimeInterval(86400), iconSystemName: "leaf", quantityInfo: "Tomorrow")
        ]
    }
    
    func getRunningLowItems() -> [PantryItem] {
        return [
            PantryItem(name: "Eggs", category: .dairy, status: .runningLow, dateAdded: Date().addingTimeInterval(-86400 * 7), expiryDate: Date().addingTimeInterval(86400 * 10), iconSystemName: "oval", quantityInfo: "Stock up on essentials.")
        ]
    }
    
    func getRecentlyAdded() -> [PantryItem] {
        return [
            PantryItem(name: "Farm Eggs", category: .dairy, status: .optimal, dateAdded: Date(), expiryDate: nil, iconSystemName: "oval", quantityInfo: "Today, 9:42 AM"),
            PantryItem(name: "Oat Milk", category: .dairy, status: .optimal, dateAdded: Date().addingTimeInterval(-86400), expiryDate: nil, iconSystemName: "cup.and.saucer", quantityInfo: "Yesterday")
        ]
    }
    
    func getRestockedThisWeek() -> [PantryItem] {
        return [
            PantryItem(name: "Sourdough", category: .pantry, status: .optimal, dateAdded: Date(), expiryDate: nil, iconSystemName: "muffin", quantityInfo: "2 Loaves"),
            PantryItem(name: "Olive Oil", category: .pantry, status: .optimal, dateAdded: Date(), expiryDate: nil, iconSystemName: "drop", quantityInfo: "1 Bottle")
        ]
    }
    
    // Simulate AI delay for insights
    func generateInsights() async throws -> [KitchenInsight] {
        try await Task.sleep(nanoseconds: 4_000_000_000)
        
        return [
            KitchenInsight(title: "Milk may be running low.", description: "Based on your usual consumption, you might need more by tomorrow.", iconSystemName: "drop", type: .info),
            KitchenInsight(title: "Bread usually lasts 5 days.", description: "You added bread 3 days ago. Consider using it soon.", iconSystemName: "muffin", type: .info),
            KitchenInsight(title: "Tomatoes should be used today.", description: "They are approaching peak ripeness.", iconSystemName: "exclamationmark", type: .warning)
        ]
    }
    
    func getRecipes() -> [Recipe] {
        return [
            Recipe(title: "Pasta Night", imageName: "pasta", prepTime: "20m", availableIngredients: ["Pasta", "Tomatoes", "Basil"], missingIngredients: ["Parmesan"], difficulty: "Easy"),
            Recipe(title: "Paneer Wrap", imageName: "wrap", prepTime: "15m", availableIngredients: ["Wraps", "Onion"], missingIngredients: ["Paneer", "Sauce"], difficulty: "Easy")
        ]
    }
    
    func getFrequentlyPurchased() -> [RestockItem] {
        return [
            RestockItem(name: "Oat Milk", quantity: "2 Cartons", iconSystemName: "cup.and.saucer"),
            RestockItem(name: "Coffee Beans", quantity: "1 Bag (12oz)", iconSystemName: "cup.and.saucer.fill"),
            RestockItem(name: "Bananas", quantity: "1 Bunch", iconSystemName: "leaf"),
            RestockItem(name: "Farm Eggs", quantity: "1 Dozen", iconSystemName: "oval")
        ]
    }
    
    func getWeeklyEssentials() -> [RestockItem] {
        return [
            RestockItem(name: "Sourdough Bread", quantity: "1 Loaf", iconSystemName: "muffin"),
            RestockItem(name: "Avocados", quantity: "4 Pack", iconSystemName: "drop", isSelected: false)
        ]
    }
    
    func getMonthlyEssentials() -> [RestockItem] {
        return [
            RestockItem(name: "Laundry Detergent", quantity: "1 Bottle (64 loads)", iconSystemName: "bubbles.and.sparkles"),
            RestockItem(name: "Olive Oil", quantity: "1 Liter", iconSystemName: "drop")
        ]
    }
    
    func generateCheckoutSummary() async throws -> CheckoutSummary {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return CheckoutSummary(estimatedBudget: 142.50, itemsAddedCount: 12, alreadyAvailableCount: 3, suggestedSavings: -24.00, deliveryTime: "Today, 4:00 PM", wasteReductionScore: 92)
    }
}
