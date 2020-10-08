import SwiftUI

struct SurveyView: View {
    
    @ObservedObject var productsVM = ProductsViewModel()
    let products: [String]
    
    var body: some View {
        ForEach(self.products, id: \.self) { id in
            if let product = productsVM.products.filter { $0.code == id }.first {
                Text(product.name)
            }
        }
        Text("survey")
    }
}
