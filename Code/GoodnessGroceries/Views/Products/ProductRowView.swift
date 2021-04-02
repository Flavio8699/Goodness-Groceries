import SwiftUI
import SDWebImageSwiftUI

struct ProductRowView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    let product: Product
    let category: Category?
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top, spacing: 15) {
                WebImage(url: URL(string: product.image_url)).resizable().frame(width: 100, height: 100).cornerRadius(7)
                VStack (alignment: .leading, spacing: 15) {
                    Text(NSLocalizedString(product.name, lang: UserSettings.language)).bold().multilineTextAlignment(.leading).lineLimit(3)
                    GeometryReader { geometry in
                        IndicatorsView(geometry: geometry, indicators: product.getIndicators(for: category))
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .navigationBarTitle((category != nil) ? NSLocalizedString(category!.name, lang: UserSettings.language) : NSLocalizedString("BACK", lang: UserSettings.language))
    }
}
