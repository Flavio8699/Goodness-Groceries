import Foundation

struct ProductIndicator: Hashable, Decodable {
    var id: String
    var applicable: Bool
    var sub_indicators: [ProductSubIndicator]
    
    func getIndicator() -> Indicator? {
        let productsVM = ProductsViewModel()
        
        return productsVM.indicators.first(where: { $0.id == self.id })
    }
}

/*extension ProductIndicator: Identifiable {
    var id: String { id }
}*/

struct ProductSubIndicator: Hashable, Decodable {
    var name: String
    var description: String
}
