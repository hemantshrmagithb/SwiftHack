import Foundation
import SwiftUI

struct ShoppingGroup: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var category: GroupCategory
    var members: [Member]
    var items: [ShoppingItem]
    var activityFeed: [ActivityEvent]
}

enum GroupCategory: String, CaseIterable, Identifiable, Hashable {
    case friends = "Friends"
    case family = "Family"
    case roommates = "Roommates"
    case trip = "Trip"
    case office = "Office"
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .friends: return "figure.wave"
        case .family: return "person.3.fill"
        case .roommates: return "house.fill"
        case .trip: return "airplane"
        case .office: return "briefcase.fill"
        }
    }
}

struct Member: Identifiable, Hashable {
    let id: UUID
    var name: String
    var avatarImageName: String? // If nil, we can use initials
    var initial: String {
        String(name.prefix(1)).uppercased()
    }
    
    static let currentUser = Member(id: UUID(), name: "Jamie", avatarImageName: nil)
    static let sarah = Member(id: UUID(), name: "Sarah J.", avatarImageName: "person.crop.circle.fill")
    static let mike = Member(id: UUID(), name: "Mike T.", avatarImageName: nil)
    static let alex = Member(id: UUID(), name: "Alex R.", avatarImageName: "person.crop.circle")
}

struct ShoppingItem: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var addedBy: Member
    var claimedBy: Member?
    var isChecked: Bool
    var price: Double?
}

struct ActivityEvent: Identifiable, Hashable {
    let id = UUID()
    let member: Member
    let action: String
    let target: String
    let timestamp: Date
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}

struct SplitRecommendation: Identifiable, Hashable {
    let id = UUID()
    let totalAmount: Double
    let remainingAmount: Double
    let splitLogic: String
    let settlements: [Settlement]
}

struct Settlement: Identifiable, Hashable {
    let id = UUID()
    let member: Member
    let amount: Double
    let isSettled: Bool
    let type: SettlementType
    
    enum SettlementType {
        case owes
        case paid
    }
}
