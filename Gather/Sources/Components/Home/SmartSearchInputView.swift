import SwiftUI

struct SmartSearchInputView: View {
    @Binding var text: String
    
    let suggestions = ["Milk", "Organic Eggs", "Bread", "Coffee"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Search Input
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.primaryText)
                    .font(.title3)
                
                TextField("Search groceries...", text: $text)
                    .font(.body)
                    .foregroundColor(.primaryText)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "mic")
                        .foregroundColor(.primaryText)
                        .font(.title3)
                }
            }
            .padding()
            .background(Color.cardBackground)
            .cornerRadius(16)
            
            // Smart Suggestions
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    Text("Smart Suggestions:")
                        .font(.caption)
                        .foregroundColor(.secondaryText)
                    
                    ForEach(suggestions, id: \.self) { suggestion in
                        Button(action: { text = suggestion }) {
                            Text(suggestion)
                                .font(.caption)
                                .foregroundColor(.primaryText)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.cardBackground)
                                .cornerRadius(20)
                        }
                    }
                }
            }
        }
    }
}
