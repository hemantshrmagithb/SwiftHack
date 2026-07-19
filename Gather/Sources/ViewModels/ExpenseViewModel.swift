import Foundation
import SwiftUI
import Observation

enum ExpenseStep {
    case home
    case createGroup
    case shoppingRoom
    case aiAnalysis
    case settlement
}

@Observable
class ExpenseViewModel {
    var currentStep: ExpenseStep = .home
    
    var groupName: String = ""
    var selectedCategory: GroupCategory = .friends
    
    var group: ShoppingGroup?
    var splitRecommendation: SplitRecommendation?
    
    private let splitService = SplitCalculationService()
    
    // Live Activity Timer
    private var activityTimer: Timer?
    
    func nextStep() {
        switch currentStep {
        case .home:
            currentStep = .createGroup
        case .createGroup:
            createMockGroup()
            currentStep = .shoppingRoom
        case .shoppingRoom:
            currentStep = .aiAnalysis
            Task {
                await performAIAnalysis()
            }
        case .aiAnalysis:
            currentStep = .settlement
        case .settlement:
            break
        }
    }
    
    func previousStep() {
        switch currentStep {
        case .home: break
        case .createGroup: currentStep = .home
        case .shoppingRoom: currentStep = .createGroup
        case .aiAnalysis: currentStep = .shoppingRoom
        case .settlement: currentStep = .shoppingRoom
        }
    }
    
    private func createMockGroup() {
        group = ShoppingGroup(
            name: groupName.isEmpty ? "Weekend Trip Groceries" : groupName,
            category: selectedCategory,
            members: [.currentUser, .sarah, .alex],
            items: [
                ShoppingItem(name: "Artisan Tortilla Chips", addedBy: .alex, claimedBy: .alex, isChecked: false),
                ShoppingItem(name: "Organic Milk", addedBy: .alex, claimedBy: .alex, isChecked: false),
                ShoppingItem(name: "Limes", addedBy: .sarah, claimedBy: .sarah, isChecked: true)
            ],
            activityFeed: [
                ActivityEvent(member: .alex, action: "added", target: "Organic Milk", timestamp: Date()),
                ActivityEvent(member: .sarah, action: "crossed off", target: "Limes", timestamp: Date().addingTimeInterval(-120)),
                ActivityEvent(member: .currentUser, action: "is looking at", target: "Snacks", timestamp: Date().addingTimeInterval(-300))
            ]
        )
    }
    
    @MainActor
    private func performAIAnalysis() async {
        guard let group = group else { return }
        do {
            splitRecommendation = try await splitService.calculateFairSplit(group: group)
            withAnimation(.spring) {
                currentStep = .settlement
            }
        } catch {
            print("Error calculating split: \\(error)")
        }
    }
    
    func toggleItemSelection(_ item: ShoppingItem) {
        guard let index = group?.items.firstIndex(where: { $0.id == item.id }) else { return }
        group?.items[index].isChecked.toggle()
    }
    
    func addItem(name: String) {
        let newItem = ShoppingItem(name: name, addedBy: .currentUser, claimedBy: .currentUser, isChecked: false)
        group?.items.append(newItem)
        // Add an activity event for the new item
        let event = ActivityEvent(member: .currentUser, action: "added", target: name, timestamp: Date())
        group?.activityFeed.insert(event, at: 0)
    }
}
