import Foundation

struct Product: Hashable, Decodable {
    let code: String
    let name: String
    let description: String
    let category: String
    let type: ProductType
    let provider: String
    let imageURL: String
    let indicators: [Indicator]
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.code == rhs.code
    }
}

enum ProductType: String, Codable {
    case localOrganic = "local_organic"
}
