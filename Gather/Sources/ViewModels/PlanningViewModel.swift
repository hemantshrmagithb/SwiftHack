import Foundation
import Observation

enum PlanningStep {
    case welcome
    case selection
    case details
    case animating
    case planReady
}

@Observable
class PlanningViewModel {
    var currentStep: PlanningStep = .welcome
    
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
    var plan: CelebrationPlan?
    var isGenerating: Bool = false
    
    private let aiService: FoundationModelServiceProtocol
    
    init(aiService: FoundationModelServiceProtocol = MockFoundationModelService()) {
        self.aiService = aiService
    }
    
    func nextStep() {
        switch currentStep {
        case .welcome:
            currentStep = .selection
        case .selection:
            if selectedOccasionType != nil {
                currentStep = .details
            }
        case .details:
            generatePlan()
        case .animating, .planReady:
            break
        }
    }
    
    func previousStep() {
        switch currentStep {
        case .selection: currentStep = .welcome
        case .details: currentStep = .selection
        case .animating, .planReady: currentStep = .details
        case .welcome: break
        }
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
        
        currentStep = .animating
        isGenerating = true
        
        Task {
            do {
                let generatedPlan = try await aiService.generatePlan(for: template)
                await MainActor.run {
                    self.plan = generatedPlan
                    self.isGenerating = false
                    self.currentStep = .planReady
                }
            } catch {
                await MainActor.run {
                    self.isGenerating = false
                    // Handle error state if needed
                    self.currentStep = .details 
                }
            }
        }
    }
}
