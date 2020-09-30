import Foundation

struct Product: Decodable, Hashable {
    var code: String
    var name: String
    var description: String
    var category: String
    var imageURL: String
    var indicators: String
}

