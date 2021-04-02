import SwiftUI

struct ProductsListView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    let category: Category
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (spacing: 0) {
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: ProductView(product: product, category: category)) {
                        ProductRowView(product: product, category: category).foregroundColor(.black)
                    }
                    Divider().padding(.horizontal)
                }
            }
        }
    }
    
    var products: [Product] {
        return self.productsVM.products.filter { product in
            for productIndicator in product.indicators {
                if let indicator = self.productsVM.indicators.first(where: { $0.id == productIndicator.indicator_id }) {
                    if indicator.category_id == category.id {
                        return true
                    }
                }
            }
            return false
        }
    }
}
