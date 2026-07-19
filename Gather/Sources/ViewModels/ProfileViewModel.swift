import Foundation
import SwiftUI
import Observation

@Observable
class ProfileViewModel {
    var user: ProfileUser?
    var healthData: HealthDietData?
    var householdData: HouseholdData?
    var dnaTraits: [BlinkZoDNA] = []
    var smartInsights: [ProfileInsight] = []
    var orderHistory: [OrderHistoryItem] = []
    
    var isLoading = false
    
    init() {
        loadData()
    }
    
    func loadData() {
        isLoading = true
        
        // Simulating network delay
        Task {
            try? await Task.sleep(nanoseconds: 600_000_000)
            
            await MainActor.run {
                self.user = ProfileUser(
                    name: "Good Evening, Arpita",
                    imageName: "person.circle.fill", // Fallback if no actual image
                    memberSince: 2026,
                    hasBlinkZoPlus: true,
                    healthyLivingScore: 92
                )
                
                self.healthData = HealthDietData(
                    proteinCurrent: 85,
                    proteinGoal: 100,
                    fruitVegCurrent: 4,
                    fruitVegGoal: 5,
                    isVegetarian: true,
                    isVegan: false,
                    isGlutenFree: true,
                    overallRating: "Excellent"
                )
                
                self.householdData = HouseholdData(
                    address: "123 BlinkZo Street, Mumbai",
                    householdSize: 4,
                    kitchenSize: "Medium",
                    monthlyBudget: 15000,
                    shoppingFrequency: "Weekly",
                    deliveryWindow: "Morning (8AM - 11AM)",
                    members: [
                        FamilyMember(name: "Arpita", type: .parent, avatarName: "person.crop.circle"),
                        FamilyMember(name: "Aman", type: .parent, avatarName: "person.crop.circle"),
                        FamilyMember(name: "Rohan", type: .child, avatarName: "person.crop.circle"),
                        FamilyMember(name: "Sia", type: .child, avatarName: "person.crop.circle")
                    ]
                )
                
                self.dnaTraits = [
                    BlinkZoDNA(title: "Planner", iconSystemName: "calendar", color: .purple),
                    BlinkZoDNA(title: "Healthy Eater", iconSystemName: "leaf", color: .green),
                    BlinkZoDNA(title: "Budget Conscious", iconSystemName: "banknote", color: .blue),
                    BlinkZoDNA(title: "Weekend Shopper", iconSystemName: "bag", color: .orange)
                ]
                
                self.smartInsights = [
                    ProfileInsight(title: "28%", subtitle: "Reduced food waste this month", iconSystemName: "leaf.arrow.triangle.circlepath", isCurrency: false),
                    ProfileInsight(title: "1,350", subtitle: "Saved using AI meal planning", iconSystemName: "indianrupeesign", isCurrency: true),
                    ProfileInsight(title: "6", subtitle: "Celebrations planned", iconSystemName: "party.popper", isCurrency: false),
                    ProfileInsight(title: "8", subtitle: "Times restocked before running out", iconSystemName: "clock", isCurrency: false)
                ]
                
                self.orderHistory = [
                    OrderHistoryItem(title: "Diwali Party Supplies", date: "Oct 24, 2026", amount: 4500, type: .occasion),
                    OrderHistoryItem(title: "Weekend Trip Snacks", date: "Oct 15, 2026", amount: 1200, type: .splitGroup),
                    OrderHistoryItem(title: "Weekly Restock", date: "Oct 10, 2026", amount: 2340, type: .restock),
                    OrderHistoryItem(title: "Quick Grocery Run", date: "Oct 5, 2026", amount: 850, type: .normal)
                ]
                
                self.isLoading = false
            }
        }
    }
}
