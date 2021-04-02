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
    
    func getIndicators(for category: Category? = nil) -> [Indicator] {
        let productsVM = ProductsViewModel()
        var result = [Indicator]()
        
        for productIndicator in indicators {
            if var indicator = productsVM.indicators.first(where: { $0.id == productIndicator.indicator_id }) {
                if (category != nil && indicator.category_id == category!.id) || category == nil {
                    indicator.product_description = productIndicator.indicator_description
                    result.append(indicator)
                }
            }
        }

        return result
    }
}

enum ProductCategory: String, Codable {
    case localOrganic = "local_organic"
    case importedOrganic = "imported_organic"
    case localConventional = "local_conventional"
    case importedConventional = "imported_conventional"
}
