import Foundation

class ProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    @Published var indicators = [Indicator]()
    
    init() {
        self.products = loadJson("products.json")
        self.indicators = loadJson("indicators.json")
    }
    
}
