import SwiftUI
import UIKit

extension Color {
    static let appBackground = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor(hex: "#FAFAFA")
    })
    
    static let cardBackground = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(white: 0.12, alpha: 1.0) : UIColor.white
    })
    
    static let primaryText = Color.primary
    static let secondaryText = Color.secondary
    
    // Pink accent for the mockup theme
    static let gatherPink = Color(hex: "#FF4D85")
    static let gatherLightPink = Color(UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#FF4D85").withAlphaComponent(0.15) : UIColor(hex: "#FFF0F5")
    })
    
    // Green accent
    static let gatherGreen = Color(hex: "#00C853")
    
    // Orange accent
    static let gatherOrange = Color(hex: "#FF9F0A")
}

// Helper to use hex codes
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue:  CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}

extension Color {
    init(hex: String) {
        self.init(uiColor: UIColor(hex: hex))
    }
}
