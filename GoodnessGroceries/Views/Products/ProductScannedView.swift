import SwiftUI

struct ProductScannedView: View {
    
    let product: Product
    
    var body: some View {
        HStack (alignment: .top) {
            ProductImageView(url: product.image_url)
            VStack (alignment: .leading, spacing: 3) {
                Text(product.name).bold().font(.system(size: 18)).fixedSize(horizontal: false, vertical: true)
                Image("GG-\(product.category.rawValue)").resizable().scaledToFit().frame(width: 45)
                Spacer(minLength: 0)
            }
            Spacer()
        }.frame(minHeight: 100, maxHeight: 120)
    }
}
