import SwiftUI

struct ExpenseCoordinator: View {
    @State private var viewModel = ExpenseViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch viewModel.currentStep {
                case .home:
                    ExpenseHomeView(viewModel: viewModel, onDismiss: { dismiss() })
                case .createGroup:
                    CreateGroupView(viewModel: viewModel)
                case .shoppingRoom:
                    SharedShoppingRoomView(viewModel: viewModel)
                case .aiAnalysis:
                    AISplitAnalysisView(viewModel: viewModel)
                case .settlement:
                    SettlementSummaryView(viewModel: viewModel, onDismiss: { dismiss() })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.currentStep != .home && viewModel.currentStep != .aiAnalysis {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            viewModel.previousStep()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primaryText)
                        }
                    }
                }
                
                if viewModel.currentStep != .home {
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
