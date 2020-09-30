import SwiftUI

struct ProductsListView: View {
    
    @ObservedObject var productsVM = ProductsViewModel()
    let category: Category
    
    var body: some View {
        ForEach(self.productsVM.products.filter { $0.category == category.name }, id: \.self) {
            Text($0.name)
        }
    }
}
