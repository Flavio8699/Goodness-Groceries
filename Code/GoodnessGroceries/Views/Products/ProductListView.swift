import SwiftUI

struct ProductListView: View {
    
    let category: Category
    let product_category: ProductCategory
    @StateObject var productsVM = ProductsViewModel()
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack {
                if products.count > 0 {
                    ForEach(products, id: \.self) { product in
                        NavigationLink(destination: ProductView(product: product, category: category)) {
                            ProductRowView(product: product, category: category).foregroundColor(.black)
                        }
                        Divider()
                    }
                } else {
                    Text("Sorry, no products found TT").padding(.vertical, 10)
                }
            }.padding(.horizontal).padding(.top, 5)
        }
    }
    
    var products: [Product] {
        return self.productsVM.products.filter { product in
            for productIndicator in product.indicators {
                if let indicator = self.productsVM.indicators.first(where: { $0.id == productIndicator.indicator_id }) {
                    if indicator.category_id == category.id && product.category == product_category {
                        return true
                    }
                }
            }
            return false
        }
    }
}
