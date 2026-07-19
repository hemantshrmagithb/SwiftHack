import SwiftUI

struct OccasionPlannerCoordinator: View {
    @State private var viewModel = PlanningViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            OccasionWelcomeView(viewModel: viewModel, onDismiss: { dismiss() })
                .navigationDestination(for: PlanningStep.self) { step in
                    switch step {
                    case .welcome:
                        OccasionWelcomeView(viewModel: viewModel, onDismiss: { dismiss() })
                    case .selection:
                        OccasionSelectionView(viewModel: viewModel)
                    case .details:
                        EventDetailsView(viewModel: viewModel)
                    case .animating:
                        PlanningAnimationView(viewModel: viewModel)
                    case .planReady:
                        AIPlanView(viewModel: viewModel, onDismiss: { dismiss() })
                    case .cartSummary:
                        CartSummaryView(viewModel: viewModel, onDismiss: { dismiss() })
                    }
                }
        }
    }
}
