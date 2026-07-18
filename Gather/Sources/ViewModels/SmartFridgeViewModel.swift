import Foundation
import SwiftUI
import Observation

enum SmartFridgeStep {
    case welcome
    case pantryOverview
    case insights
    case recipes
    case restock
    case checkoutSummary
    case checkoutConfirmation
}

@Observable
class SmartFridgeViewModel {
    var currentStep: SmartFridgeStep = .welcome
    
    // Pantry Data
    var freshItems: [PantryItem] = []
    var expiringSoonItems: [PantryItem] = []
    var runningLowItems: [PantryItem] = []
    var recentlyAdded: [PantryItem] = []
    var restockedThisWeek: [PantryItem] = []
    
    // Insights & Recipes
    var insights: [KitchenInsight] = []
    var recipes: [Recipe] = []
    
    // Restock Data
    var frequentlyPurchased: [RestockItem] = []
    var weeklyEssentials: [RestockItem] = []
    var monthlyEssentials: [RestockItem] = []
    
    // Checkout
    var checkoutSummary: CheckoutSummary?
    
    private let analysisService = PantryAnalysisService()
    
    init() {
        loadPantryData()
    }
    
    private func loadPantryData() {
        freshItems = analysisService.getFreshItems()
        expiringSoonItems = analysisService.getExpiringSoonItems()
        runningLowItems = analysisService.getRunningLowItems()
        recentlyAdded = analysisService.getRecentlyAdded()
        restockedThisWeek = analysisService.getRestockedThisWeek()
        
        frequentlyPurchased = analysisService.getFrequentlyPurchased()
        weeklyEssentials = analysisService.getWeeklyEssentials()
        monthlyEssentials = analysisService.getMonthlyEssentials()
    }
    
    func nextStep() {
        switch currentStep {
        case .welcome:
            currentStep = .pantryOverview
        case .pantryOverview:
            currentStep = .insights
            Task {
                await generateInsightsAndRecipes()
            }
        case .insights:
            currentStep = .recipes
        case .recipes:
            currentStep = .restock
        case .restock:
            currentStep = .checkoutSummary
            Task {
                await generateCheckoutSummary()
            }
        case .checkoutSummary:
            currentStep = .checkoutConfirmation
        case .checkoutConfirmation:
            break
        }
    }
    
    func previousStep() {
        switch currentStep {
        case .welcome: break
        case .pantryOverview: currentStep = .welcome
        case .insights: currentStep = .pantryOverview
        case .recipes: currentStep = .insights
        case .restock: currentStep = .recipes
        case .checkoutSummary: currentStep = .restock
        case .checkoutConfirmation: currentStep = .checkoutSummary
        }
    }
    
    func skipToRestock() {
        currentStep = .restock
    }
    
    @MainActor
    private func generateInsightsAndRecipes() async {
        do {
            insights = try await analysisService.generateInsights()
            recipes = analysisService.getRecipes()
            // Wait an extra second before moving to recipes to let user read
            try await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation(.spring) {
                currentStep = .recipes
            }
        } catch {
            print("Error generating insights: \\(error)")
        }
    }
    
    @MainActor
    private func generateCheckoutSummary() async {
        do {
            checkoutSummary = try await analysisService.generateCheckoutSummary()
        } catch {
            print("Error generating checkout summary: \\(error)")
        }
    }
    
    func toggleWeeklyEssential(_ item: RestockItem) {
        if let index = weeklyEssentials.firstIndex(where: { $0.id == item.id }) {
            weeklyEssentials[index].isSelected.toggle()
        }
    }
    
    func toggleMonthlyEssential(_ item: RestockItem) {
        if let index = monthlyEssentials.firstIndex(where: { $0.id == item.id }) {
            monthlyEssentials[index].isSelected.toggle()
        }
    }
}
