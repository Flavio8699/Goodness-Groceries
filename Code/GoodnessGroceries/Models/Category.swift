import Foundation

struct Category: Identifiable, Hashable, Decodable {
    var id: String
    var name: String
    var icon_name: String
    var description: String
    
    func getIndicators() -> [Indicator] {
        let productsVM = ProductsViewModel()
        var result = [Indicator]()
        
        for indicator in productsVM.indicators {
            if indicator.category_id == id {
                result.append(indicator)
            }
        }

        return result
    }
}


