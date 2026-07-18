import Foundation

struct Feature: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let iconSystemName: String
    let buttonTitle: String
    let buttonActionType: ActionType
    
    enum ActionType {
        case primary
        case secondary
        case success
    }
}
