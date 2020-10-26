import Foundation

struct Product: Hashable, Decodable {
    var code: String
    var name: String
    var description: String
    var type: String
    var category: ProductCategory
    var provider: String
    var image_url: String
    var indicators: [ProductIndicator]
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.code == rhs.code
    }
}

enum ProductCategory: String, Codable {
    case localOrganic = "local_organic"
    case importedOrganic = "imported_organic"
    case localConventional = "local_conventional"
    case importedConventional = "imported_conventional"
}
