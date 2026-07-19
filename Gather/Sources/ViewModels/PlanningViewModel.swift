import Foundation
import Observation

enum PlanningStep: Hashable {
    case welcome
    case selection
    case details
    case animating
    case planReady
    case cartSummary
}

@Observable
class PlanningViewModel {
    var path: [PlanningStep] = []
    
    var selectedOccasionType: OccasionType?
    
    // Details Form State
    var eventDate = Date()
    var eventTime = Date()
    var adultGuests: Int = 12
    var childGuests: Int = 4
    var isIndoor: Bool = true
    var budgetEstimate: Double = 1500
    var selectedDiets: Set<DietaryPreference> = [.nonVeg]
    
    // AI Generated Plan
    var plan: OccasionPlan?
    var isGenerating: Bool = false
    
    // Sequential Animation State
    var reasoningStateIndex: Int = 0
    let reasoningStates: [String] = [
        "Understanding celebration...",
        "Estimating guest requirements...",
        "Calculating quantities...",
        "Optimizing budget...",
        "Building shopping checklist...",
        "Generating timeline...",
        "Preparing recommendations...",
        "Finalizing shopping cart..."
    ]
    var currentReasoningState: String {
        guard reasoningStateIndex < reasoningStates.count else { return "Almost done..." }
        return reasoningStates[reasoningStateIndex]
    }
    
    private let aiService: FoundationModelServiceProtocol
    
    init(aiService: FoundationModelServiceProtocol = FoundationModelService()) {
        self.aiService = aiService
    }
    
    func toggleDietary(_ diet: DietaryPreference) {
        if selectedDiets.contains(diet) {
            selectedDiets.remove(diet)
        } else {
            selectedDiets.insert(diet)
        }
    }
    
    func generatePlan() {
        guard let type = selectedOccasionType else { return }
        
        let template = OccasionTemplate(
            type: type,
            date: eventDate,
            time: eventTime,
            adultGuests: adultGuests,
            childGuests: childGuests,
            isIndoor: isIndoor,
            budget: budgetEstimate,
            dietaryPreferences: Array(selectedDiets)
        )
        
        path.append(.animating)
        isGenerating = true
        reasoningStateIndex = 0
        
        Task {
            // Start the sequential animation timer in a separate task
            let animationTask = Task {
                for _ in 0..<reasoningStates.count {
                    try? await Task.sleep(nanoseconds: 600_000_000)
                    if Task.isCancelled { break }
                    await MainActor.run {
                        if self.reasoningStateIndex < self.reasoningStates.count - 1 {
                            self.reasoningStateIndex += 1
                        }
                    }
                }
            }
            
            do {
                let generatedPlan = try await aiService.generatePlan(for: template)
                animationTask.cancel()
                
                await MainActor.run {
                    self.plan = generatedPlan
                    self.isGenerating = false
                    self.path.append(.planReady)
                }
            } catch {
                animationTask.cancel()
                await MainActor.run {
                    self.isGenerating = false
                    if !self.path.isEmpty {
                        self.path.removeLast() // go back to details on error
                    }
                }
            }
        }
    }
}
