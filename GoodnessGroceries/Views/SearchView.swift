import SwiftUI

struct SearchView: View {
    
    let products: [Product]
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack (spacing: 0) {
            if products.count > 0 {
                ForEach(products, id: \.self) { product in
                    NavigationLink(destination: ProductView(product: product, category: nil)) {
                        ProductRowView(product: product, category: nil)
                            .foregroundColor(.black)
                            .navigationBarTitle(NSLocalizedString("SEARCH", lang: UserSettings.language))
                    }
                    Divider()
                }
            } else {
                Text(NSLocalizedString("NO_PRODUCTS_FOUND", lang: UserSettings.language)).padding(.vertical, 10)
            }
            Spacer(minLength: 0)
        }
    }
}
