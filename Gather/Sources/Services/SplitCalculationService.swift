import Foundation

@Observable
class SplitCalculationService {
    
    /// Simulates calling the Apple Foundation Model to perform reasoning over a shopping list and generate a fair split.
    func calculateFairSplit(group: ShoppingGroup) async throws -> SplitRecommendation {
        // In a real app, this would use FoundationModelService and pass the group data to the LLM.
        // We simulate the delay for the animation.
        try await Task.sleep(nanoseconds: 3_500_000_000) // 3.5 seconds
        
        return SplitRecommendation(
            totalAmount: 142.50,
            remainingAmount: 45.00,
            splitLogic: "Based on the items selected, costs have been divided proportionally. Shared items are split evenly, while specific requests are assigned individually.",
            settlements: [
                Settlement(member: Member.sarah, amount: 35.00, isSettled: false, type: .owes),
                Settlement(member: Member.mike, amount: 62.50, isSettled: true, type: .paid),
                Settlement(member: Member.alex, amount: 45.00, isSettled: false, type: .owes)
            ]
        )
    }
}
