import Foundation

struct ProductBought: Decodable {
    let customer: String
    let product_name: String
    let product_code: String
    let price: Double
}
