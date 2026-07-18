import Foundation

struct Category: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let iconSystemName: String
    var isSelected: Bool = false
    var isNew: Bool = false
}
