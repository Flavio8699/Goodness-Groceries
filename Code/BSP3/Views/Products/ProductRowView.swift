import SwiftUI
import SDWebImageSwiftUI

struct ProductRowView: View {
    
    @ObservedObject var productsVM = ProductsViewModel()
    let product: Product
    let category: Category
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top, spacing: 15) {
                WebImage(url: URL(string: product.image_url)).resizable().frame(width: 100, height: 100).cornerRadius(7)
                VStack (alignment: .leading, spacing: 15) {
                    Text(product.name).bold().multilineTextAlignment(.leading).lineLimit(3)
                    HStack(alignment: .top, spacing: 10) {
                        ForEach(product.indicators, id: \.self) { productIndicator in
                            if let indicator = productsVM.indicators.first(where: { $0.id == productIndicator.indicator_id }) {
                                if indicator.category_id == category.id {
                                    Image(indicator.icon_name)
                                }
                            }
                        }
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .frame(height: 120)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}
