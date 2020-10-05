import SwiftUI

struct ProductsListView: View {
    
    @ObservedObject var productsVM = ProductsViewModel()
    let category: Category
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (spacing: 0) {
                let products = self.productsVM.products.filter { product in
                    for indicator in category.indicators {
                        for productIndicator in product.indicators {
                            if productIndicator.id == indicator {
                                return true
                            }
                        }
                    }
                    return false
                }
                
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: ProductView(product: product)) {
                        ProductRowView(product: product, hideSeparator: (product == products.last)).foregroundColor(.black)
                    }
                }
                .navigationBarTitle("Liste des produits")
            }
        }
    }
}
