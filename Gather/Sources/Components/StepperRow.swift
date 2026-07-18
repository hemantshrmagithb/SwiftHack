import SwiftUI

struct StepperRow: View {
    let title: String
    let subtitle: String
    @Binding var value: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primaryText)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondaryText)
            }
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    if value > 0 { value -= 1 }
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.primaryText)
                        .frame(width: 32, height: 32)
                }
                
                Text("\(value)")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.primaryText)
                    .frame(width: 30, alignment: .center)
                
                Button(action: {
                    value += 1
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.primaryText)
                        .frame(width: 32, height: 32)
                }
            }
        }
        .padding(.vertical, 12)
    }
}
