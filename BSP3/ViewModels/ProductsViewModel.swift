import Foundation

class ProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    
    init() {
        self.products = loadJson("products.json")
    }
    
}
