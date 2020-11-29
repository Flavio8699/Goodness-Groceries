import Foundation

struct Category: Identifiable, Hashable, Decodable {
    var id: String
    var name: String
    var icon_name: String
    var description: String
    var color: String
}
