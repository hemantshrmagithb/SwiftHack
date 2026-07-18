import Foundation
import SwiftUI

enum OccasionType: String, CaseIterable, Identifiable {
    case birthday = "Birthday"
    case houseParty = "House Party"
    case dinner = "Dinner"
    case movieNight = "Movie Night"
    case festival = "Festival"
    case anniversary = "Anniversary"
    case officeEvent = "Office Event"
    case custom = "Custom"
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .birthday: return "birthday.cake" // Using standard SF Symbol or custom if not available
        case .houseParty: return "music.mic"
        case .dinner: return "fork.knife"
        case .movieNight: return "popcorn"
        case .festival: return "party.popper"
        case .anniversary: return "heart.fill"
        case .officeEvent: return "briefcase.fill"
        case .custom: return "plus"
        }
    }
}

struct OccasionTemplate: Identifiable {
    let id = UUID()
    let type: OccasionType
    var date: Date
    var time: Date
    var adultGuests: Int
    var childGuests: Int
    var isIndoor: Bool
    var budget: Double
    var dietaryPreferences: [DietaryPreference]
}

enum DietaryPreference: String, CaseIterable, Identifiable {
    case vegetarian = "Vegetarian"
    case nonVeg = "Non-Veg"
    case vegan = "Vegan"
    
    var id: String { self.rawValue }
}
