import SwiftUI

struct FeatureCardView: View {
    var feature: Feature
    var action: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                Image(systemName: feature.iconSystemName)
                    .font(.title2)
                    .foregroundColor(iconColor)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color.cardBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                
                Spacer()
                
                if feature.buttonActionType == .success {
                    Button(action: action) {
                        Text(feature.buttonTitle)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gatherGreen)
                            .cornerRadius(20)
                    }
                } else if feature.buttonActionType == .secondary {
                    Button(action: action) {
                        Text(feature.buttonTitle)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.primaryText)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.cardBackground)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.body)
                    .fontWeight(.medium)
                
                HStack(spacing: 4) {
                    if feature.buttonActionType == .secondary {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 6, height: 6)
                    }
                    Text(feature.description)
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
            }
            
            if feature.buttonActionType == .primary {
                Button(action: action) {
                    Text(feature.buttonTitle)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.primaryText)
                        .cornerRadius(8)
                }
            }
        }
        .padding(16)
        .background(Color.appBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
    
    private var iconColor: Color {
        switch feature.buttonActionType {
        case .primary: return .black
        case .secondary: return .gray
        case .success: return .black
        }
    }
}
