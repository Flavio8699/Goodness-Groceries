import SwiftUI

struct SearchView: View {
    
    let products: [Product]
    
    var body: some View {
        VStack (spacing: 0) {
            ForEach(products, id: \.self) { product in
                NavigationLink(destination: ProductView(product: product, category: nil)) {
                    ProductRowView(product: product, category: nil)
                        .foregroundColor(.black)
                        .animation(Animation.default)
                }
                Divider()
            }
            Spacer(minLength: 0)
        }
    }
}
