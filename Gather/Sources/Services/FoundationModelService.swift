import Foundation

protocol FoundationModelServiceProtocol {
    func generatePlan(for template: OccasionTemplate) async throws -> CelebrationPlan
}

class MockFoundationModelService: FoundationModelServiceProtocol {
    func generatePlan(for template: OccasionTemplate) async throws -> CelebrationPlan {
        // Simulate network delay for the AI planning animation
        try await Task.sleep(nanoseconds: 3_500_000_000)
        
        return CelebrationPlan(
            title: "\(template.type.rawValue) Gathering",
            timeline: [
                TimelineEvent(title: "Setup & Decor", description: "Arrange seating, hang string lights, and set up the drink station.", timeString: "4:00 PM"),
                TimelineEvent(title: "Guests Arrive", description: "Welcome drinks served. Play 'Acoustic Chill' playlist.", timeString: "5:30 PM"),
                TimelineEvent(title: "Dinner Served", description: "Main courses ready. Ensure dietary options are labeled.", timeString: "7:00 PM")
            ],
            checklist: [
                ChecklistCategory(name: "Food", iconName: "fork.knife", itemCount: 12, progress: 0.8),
                ChecklistCategory(name: "Drinks", iconName: "wineglass", itemCount: 8, progress: 0.4),
                ChecklistCategory(name: "Desserts", iconName: "birthday.cake", itemCount: 3, progress: 0.1),
                ChecklistCategory(name: "Decor", iconName: "party.popper", itemCount: 5, progress: 1.0)
            ],
            totalBudget: template.budget > 0 ? template.budget : 342.50,
            groceriesBudget: 215.00,
            decorBudget: 85.50,
            bufferBudget: 42.00,
            wasteReductionTip: "Based on \(template.adultGuests + template.childGuests) guests, consider halving the dessert order. Past data shows 40% dessert surplus for dinner events.",
            recommendedCombo: "Pairing the Lemon Herb Chicken with the Citrus Cooler saves $12 on shared ingredients."
        )
    }
}
