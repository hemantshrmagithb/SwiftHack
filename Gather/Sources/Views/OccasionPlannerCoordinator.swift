import SwiftUI

struct OccasionPlannerCoordinator: View {
    @State private var viewModel = PlanningViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.currentStep {
                case .welcome:
                    OccasionWelcomeView(viewModel: viewModel, onDismiss: { dismiss() })
                case .selection:
                    OccasionSelectionView(viewModel: viewModel)
                case .details:
                    EventDetailsView(viewModel: viewModel)
                case .animating:
                    PlanningAnimationView()
                case .planReady:
                    AIPlanView(viewModel: viewModel, onDismiss: { dismiss() })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.currentStep != .welcome && viewModel.currentStep != .animating {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.previousStep()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primaryText)
                        }
                    }
                }
                
                if viewModel.currentStep != .welcome {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.primaryText)
                        }
                    }
                }
            }
        }
    }
}
