import SwiftUI

struct HealthZoneCard: View {
    let healthData: HealthDietData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "waveform.path.ecg")
                        .foregroundColor(.blinkZoGreen)
                    Text("Health & Diet")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryText)
                }
                Spacer()
                Image(systemName: "chart.bar.xaxis")
                    .font(.system(size: 40))
                    .foregroundColor(.gray.opacity(0.1))
            }
            
            // Protein Goal
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Protein Goal")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryText)
                    Spacer()
                    Text("\\(healthData.proteinCurrent)g / \\(healthData.proteinGoal)g")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 8)
                        
                        Capsule()
                            .fill(Color.primaryText)
                            .frame(width: geometry.size.width * healthData.proteinProgress, height: 8)
                    }
                }
                .frame(height: 8)
            }
            
            // Fruit & Veg Goal
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Fruit & Veg")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primaryText)
                    Spacer()
                    Text("\\(healthData.fruitVegCurrent) / \\(healthData.fruitVegGoal) servings")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 8)
                        
                        Capsule()
                            .fill(Color.blinkZoGreen)
                            .frame(width: geometry.size.width * healthData.fruitVegProgress, height: 8)
                    }
                }
                .frame(height: 8)
            }
            
            // Tags
            HStack(spacing: 8) {
                if healthData.isVegetarian {
                    dietTag("Vegetarian")
                }
                if healthData.isGlutenFree {
                    dietTag("Gluten-Free")
                }
                if healthData.isVegan {
                    dietTag("Vegan")
                }
            }
            
            // Analysis Card
            VStack(spacing: 12) {
                Text(healthData.overallRating)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primaryText)
                
                HStack {
                    Text("Weekly AI Analysis")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                    Spacer()
                    Button(action: {}) {
                        Text("View Details")
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .foregroundColor(.primaryText)
                            .cornerRadius(16)
                    }
                }
            }
            .padding(20)
            .background(Color.appBackground)
            .cornerRadius(20)
        }
        .padding(24)
        .background(Color.cardBackground)
        .cornerRadius(32)
    }
    
    private func dietTag(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.secondaryText)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.appBackground)
            .cornerRadius(16)
    }
}
