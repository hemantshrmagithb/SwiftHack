import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let currentPrice: Int
    let originalPrice: Int?
    let discountTag: String?
    let imageSystemName: String
    let isTopDeal: Bool
}
