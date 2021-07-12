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
    
    func getIndicators(for category: Category? = nil, except ignoreCategory: Category? = nil) -> [Indicator] {
        let productsVM = ProductsViewModel()
        var result = [Indicator]()
        
        for productIndicator in self.indicators {
            if productIndicator.applicable && productIndicator.sub_indicators.count > 0 {
                if let indicator = productsVM.indicators.first(where: { $0.id == productIndicator.id }) {
                    if category != nil && indicator.category_id == category!.id || category == nil {
                        if ignoreCategory != nil && indicator.category_id != ignoreCategory!.id || ignoreCategory == nil {
                            result.append(indicator)
                        }
                    }
                }
            }
        }

        return result
    }
    
    func getSimilarProducts() -> [Product]  {
        let productsVM = ProductsViewModel()
        
        return productsVM.products.filter({ $0.type == self.type && $0 != self })
    }
    
    func getCompareProducts() -> [Product]  {
        let productsVM = ProductsViewModel()
        
        return productsVM.products.filter({ $0.type == self.type })
    }
    
    func hasIndicator(indicator: Indicator) -> CompareResult {
        if let productIndicator = self.indicators.first(where: { $0.id == indicator.id }) {
            if !productIndicator.applicable {
                return .not_applicable
            } else {
                return productIndicator.sub_indicators.count > 0 ? .yes : .no
            }
        }
        return .no
    }
}

enum CompareResult {
    case yes
    case no
    case not_applicable
}
