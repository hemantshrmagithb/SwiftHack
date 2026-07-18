import Foundation

class MockDataService {
    static let shared = MockDataService()
    
    func getCategories() -> [Category] {
        return [
            Category(name: "All", iconSystemName: "square.grid.2x2", isSelected: true),
            Category(name: "Monsoon", iconSystemName: "umbrella"),
            Category(name: "Electronics", iconSystemName: "headphones"),
            Category(name: "Beauty", iconSystemName: "face.smiling", isNew: true),
            Category(name: "Decor", iconSystemName: "sofa")
        ]
    }
    
    func getTopDeal() -> Product {
        Product(name: "Kajal", currentPrice: 379, originalPrice: 450, discountTag: nil, imageSystemName: "eye.fill", isTopDeal: true)
    }
    
    func getProducts() -> [Product] {
        return [
            Product(name: "Skin Care Essentials", currentPrice: 0, originalPrice: nil, discountTag: "Up to 75% OFF", imageSystemName: "drop.fill", isTopDeal: false),
            Product(name: "Makeup & Fragrances", currentPrice: 0, originalPrice: nil, discountTag: "Up to 80% OFF", imageSystemName: "sparkles", isTopDeal: false)
        ]
    }
    
    func getFeatures() -> [Feature] {
        return [
            Feature(title: "Occasion Planner", description: "AI planning for celebrations", iconSystemName: "calendar", buttonTitle: "Plan Now", buttonActionType: .primary),
            Feature(title: "AI Fridge Assistant", description: "3 items expiring soon", iconSystemName: "refrigerator", buttonTitle: "Open Fridge", buttonActionType: .secondary),
            Feature(title: "Split Expenses", description: "Pending: ₹450", iconSystemName: "banknote", buttonTitle: "Settle Up", buttonActionType: .success)
        ]
    }
}
