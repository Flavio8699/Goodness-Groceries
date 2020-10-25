import SwiftUI
import SDWebImageSwiftUI

struct ProductRowView: View {
    
    let product: Product
    let hideSeparator: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack (alignment: .top, spacing: 15) {
                WebImage(url: URL(string: product.image_url)).resizable().frame(width: 100, height: 100).cornerRadius(7)
                Text(product.name).bold().multilineTextAlignment(.leading).lineLimit(3)
                Spacer(minLength: 0)
            }
            if !hideSeparator {
                Spacer()
                Rectangle()
                    .frame(height: 1, alignment: .bottom)
                    .foregroundColor(Color.black.opacity(0.5))
            }
        }
        .frame(height: 120)
        .padding([.horizontal, .top])
    }
}
