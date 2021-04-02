import Foundation

struct ProductIndicator: Hashable, Decodable {
    var indicator_id: String
    var indicator_description: String
}

extension ProductIndicator: Identifiable {
    var id: String { indicator_id }
}
