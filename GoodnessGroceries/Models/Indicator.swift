import Foundation

struct Indicator: Identifiable, Hashable, Decodable {
    var id: String
    var name: String
    var category_id: String
    var icon_name: String
    var general_description: String
}

extension Indicator: Equatable {
    static func == (lhs: Indicator, rhs: Indicator) -> Bool {
        return lhs.id == rhs.id
    }
}
