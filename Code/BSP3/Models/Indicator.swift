import Foundation

struct Indicator: Hashable, Decodable {
    var id: String
    var name: String
    var category_id: String
    var icon_name: String
    var general_description: String
}
