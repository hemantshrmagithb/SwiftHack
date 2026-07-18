import Foundation
import SwiftUI

// MARK: - AI Insight Model
struct AIInsight: Identifiable {
    let id = UUID()
    let text: String
    let ctaTitle: String
    let iconName: String
}

// MARK: - Quick Action Model
struct QuickAction: Identifiable {
    let id = UUID()
    let title: String
    let iconSystemName: String
    let targetTab: Int?
}

// MARK: - Journey Progress Model
struct JourneyProgress: Identifiable {
    let id = UUID()
    let title: String
    let progressText: String
    let progressPercentage: Double
    let iconSystemName: String
}

// MARK: - Recommendation Model
struct Recommendation: Identifiable {
    let id = UUID()
    let title: String
    let iconSystemName: String
    let color: Color
}
