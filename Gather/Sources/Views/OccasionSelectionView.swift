import SwiftUI

struct OccasionSelectionView: View {
    @Bindable var viewModel: PlanningViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("What are we celebrating?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primaryText)
                
                Text("Choose an occasion to start planning. We'll set up the perfect template based on your choice.")
                    .font(.body)
                    .foregroundColor(.secondaryText)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 24)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(OccasionType.allCases) { type in
                        OccasionTypeCard(
                            title: type.rawValue,
                            iconSystemName: type.iconName,
                            isSelected: viewModel.selectedOccasionType == type
                        ) {
                            viewModel.selectedOccasionType = type
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 100)
            }
        }
        .background(Color.appBackground.edgesIgnoringSafeArea(.all))
        .overlay(
            VStack {
                Spacer()
                Button(action: {
                    if viewModel.selectedOccasionType != nil {
                        viewModel.path.append(.details)
                    }
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(viewModel.selectedOccasionType == nil ? Color.gray.opacity(0.5) : Color.blinkZoGreen)
                        .cornerRadius(30)
                }
                .disabled(viewModel.selectedOccasionType == nil)
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.appBackground.opacity(0), Color.appBackground]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 120)
                )
            }
            , alignment: .bottom
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}
