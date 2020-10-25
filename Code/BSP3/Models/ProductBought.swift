import Foundation

struct ProductBought: Decodable {
    var customer: String
    var product_name: String
    var product_code: String
    var price: Double
}
