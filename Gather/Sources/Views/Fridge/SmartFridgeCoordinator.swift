import SwiftUI

struct SmartFridgeCoordinator: View {
    @State private var viewModel = SmartFridgeViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch viewModel.currentStep {
                case .welcome:
                    SmartFridgeWelcomeView(viewModel: viewModel, onDismiss: { dismiss() })
                case .pantryOverview:
                    PantryOverviewView(viewModel: viewModel)
                case .insights:
                    AIInsightsView(viewModel: viewModel, isReasoning: true)
                case .recipes:
                    AIInsightsView(viewModel: viewModel, isReasoning: false)
                case .restock:
                    RestockDashboardView(viewModel: viewModel)
                case .checkoutSummary:
                    CheckoutSummaryView(viewModel: viewModel)
                case .checkoutConfirmation:
                    CheckoutConfirmationView(onDismiss: { dismiss() })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.currentStep != .welcome && viewModel.currentStep != .checkoutConfirmation && viewModel.currentStep != .insights {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.previousStep()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primaryText)
                        }
                    }
                }
                
                if viewModel.currentStep != .welcome && viewModel.currentStep != .checkoutConfirmation {
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
