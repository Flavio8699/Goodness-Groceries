import SwiftUI

struct ProductRowView: View {
    
    let product: Product
    let category: Category?
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(NSLocalizedString(product.name, lang: UserSettings.language)).font(.headline)
                Spacer(minLength: 0)
                Image("arrow_right").padding(.top, 4)
            }
            HStack (alignment: .top) {
                ProductImageView(url: product.image_url)
                IndicatorsView(indicators: product.getIndicators(for: category))
            }
        }
        .padding(.vertical, 5)
        .navigationBarTitle(NSLocalizedString(category?.name != nil ? "PRODUCTS" : "BACK", lang: UserSettings.language))
    }
}
