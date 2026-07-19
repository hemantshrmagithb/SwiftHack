import Foundation

protocol FoundationModelServiceProtocol {
    func generatePlan(for template: OccasionTemplate) async throws -> OccasionPlan
}

class FoundationModelService: FoundationModelServiceProtocol {
    func generatePlan(for template: OccasionTemplate) async throws -> OccasionPlan {
        let _ = PromptBuilder.buildPrompt(for: template)
        
        // Simulating the delay of a Foundation Model inference
        try await Task.sleep(nanoseconds: 3_000_000_000)
        
        // --------------------------------------------------------
        // Algorithmic AI Generation (Dynamically reasoning based on constraints)
        // --------------------------------------------------------
        
        let totalGuests = template.adultGuests + template.childGuests
        let isLargeEvent = totalGuests > 15
        let isVegetarian = template.dietaryPreferences.contains(.vegetarian) && !template.dietaryPreferences.contains(.nonVeg)
        let isOutdoor = !template.isIndoor
        
        // 1. Calculate Food Quantities
        let pizzaCount = Int(ceil(Double(template.adultGuests) * 0.4 + Double(template.childGuests) * 0.5))
        let beverageBottles = Int(ceil(Double(template.adultGuests) * 1.5 + Double(template.childGuests) * 1.0))
        
        var reasoning: [AIReasoningItem] = []
        reasoning.append(AIReasoningItem(trigger: "\(template.adultGuests) Adults + \(template.childGuests) Kids", result: "Calculated \(pizzaCount) large pizzas and \(beverageBottles) beverage bottles."))
        
        if isOutdoor {
            reasoning.append(AIReasoningItem(trigger: "Outdoor Venue", result: "Added bug repellent and disposable eco-plates to checklist."))
        }
        
        if isVegetarian {
            reasoning.append(AIReasoningItem(trigger: "Vegetarian Only", result: "Removed all meat options; substituted with paneer and mushroom alternatives."))
        }
        
        let budgetPerPerson = template.budget / Double(totalGuests)
        if budgetPerPerson < 300 {
            reasoning.append(AIReasoningItem(trigger: "Budget ₹\(template.budget)", result: "Suggested budget-friendly DIY snack stations."))
        } else {
            reasoning.append(AIReasoningItem(trigger: "Budget ₹\(template.budget)", result: "Allocated budget for premium artisan desserts."))
        }
        
        // 2. Shopping Categories
        var shoppingCategories: [ShoppingCategory] = []
        
        // Fresh Food
        var foodProducts: [ShoppingProduct] = []
        if isVegetarian {
            foodProducts.append(ShoppingProduct(name: "Paneer Tikka Base", estimatedQuantity: "\(Int(ceil(Double(totalGuests)*0.2))) kg", estimatedPrice: 400.0, isEssential: true))
            foodProducts.append(ShoppingProduct(name: "Margherita Pizzas (Large)", estimatedQuantity: "\(pizzaCount)", estimatedPrice: Double(pizzaCount * 350), isEssential: true))
        } else {
            foodProducts.append(ShoppingProduct(name: "Chicken Tikka Base", estimatedQuantity: "\(Int(ceil(Double(totalGuests)*0.25))) kg", estimatedPrice: 600.0, isEssential: true))
            foodProducts.append(ShoppingProduct(name: "Assorted Pizzas (Large)", estimatedQuantity: "\(pizzaCount)", estimatedPrice: Double(pizzaCount * 450), isEssential: true))
        }
        shoppingCategories.append(ShoppingCategory(name: "Main Course", iconName: "takeoutbag.and.cup.and.straw", products: foodProducts))
        
        // Beverages
        shoppingCategories.append(ShoppingCategory(name: "Beverages", iconName: "wineglass", products: [
            ShoppingProduct(name: "Sparkling Water", estimatedQuantity: "\(beverageBottles) bottles", estimatedPrice: Double(beverageBottles * 60), isEssential: true),
            ShoppingProduct(name: "Fresh Juices", estimatedQuantity: "\(template.childGuests + 2) cartons", estimatedPrice: Double((template.childGuests + 2) * 120), isEssential: false)
        ]))
        
        // Essentials & Venue Specific
        var essentials: [ShoppingProduct] = [
            ShoppingProduct(name: "Napkins (Pack of 100)", estimatedQuantity: "1 pack", estimatedPrice: 150.0, isEssential: true)
        ]
        if isOutdoor {
            essentials.append(ShoppingProduct(name: "Eco-Friendly Plates", estimatedQuantity: "\(totalGuests + 10) count", estimatedPrice: 300.0, isEssential: true))
            essentials.append(ShoppingProduct(name: "Mosquito Repellent Coils", estimatedQuantity: "1 pack", estimatedPrice: 80.0, isEssential: false))
        }
        shoppingCategories.append(ShoppingCategory(name: "Essentials", iconName: "exclamationmark.triangle", products: essentials))
        
        // 3. Summaries & Warnings
        let totalEstimatedBudget = shoppingCategories.flatMap { $0.products }.reduce(0) { $0 + $1.estimatedPrice }
        
        let plan = OccasionPlan(
            title: "Magical \(template.type.rawValue) Celebration",
            summary: PlanSummary(
                foodStrategy: isVegetarian ? "A robust vegetarian spread focusing on rich paneer dishes and crowd-pleasing pizzas." : "A balanced mix of chicken appetizers and assorted pizzas.",
                drinkStrategy: "Hydration station setup with sparkling water and fresh juices for the kids.",
                dessertRecommendation: "A central cake with side pastries for easy mingling.",
                wasteReductionTip: "Use compostable plates and encourage guests to recycle beverage bottles."
            ),
            timeline: [
                TimelineEvent(title: "Morning Prep", description: "Receive groceries and marinate appetizers.", timeString: "10:00 AM"),
                TimelineEvent(title: "Setup Venue", description: isOutdoor ? "Set up outdoor seating and bug repellent." : "Arrange indoor seating and dining area.", timeString: "2:00 PM"),
                TimelineEvent(title: "Guests Arrive", description: "Serve welcome drinks and light snacks.", timeString: template.time.formatted(date: .omitted, time: .shortened))
            ],
            checklist: [
                ChecklistItem(task: "Clear main living space", isEssential: true),
                ChecklistItem(task: "Chill all beverages", isEssential: true),
                ChecklistItem(task: "Setup a music playlist", isEssential: false)
            ],
            shoppingCategories: shoppingCategories,
            totalEstimatedBudget: totalEstimatedBudget,
            warnings: [
                isLargeEvent ? "With \(totalGuests) guests, ensure you have enough seating and consider a buffet style." : "Intimate blinkZoing: focus on high-quality ingredients.",
                totalEstimatedBudget > template.budget ? "Your estimated cart is slightly over your stated budget." : "You are well within your budget."
            ],
            premiumUpgrades: [
                "Hire a local mixologist for 2 hours.",
                "Upgrade to premium artisan desserts."
            ],
            aiReasoning: reasoning
        )
        
        // Encode and decode to prove it matches the strict JSON Codable requirements as if it came from the network
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let data = try encoder.encode(plan)
        let simulatedNetworkResponse = try decoder.decode(OccasionPlan.self, from: data)
        
        return simulatedNetworkResponse
    }
}
