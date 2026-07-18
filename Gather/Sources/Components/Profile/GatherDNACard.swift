import SwiftUI

struct GatherDNACard: View {
    let traits: [GatherDNA]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("My Gather DNA")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primaryText)
                .padding(.horizontal, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    Spacer().frame(width: 8)
                    ForEach(traits) { trait in
                        VStack(spacing: 12) {
                            Circle()
                                .fill(trait.color.opacity(0.1))
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: trait.iconSystemName)
                                        .font(.title2)
                                        .foregroundColor(trait.color)
                                )
                            
                            Text(trait.title)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 110, height: 130)
                        .background(Color.cardBackground)
                        .cornerRadius(24)
                    }
                    Spacer().frame(width: 8)
                }
            }
        }
    }
}
