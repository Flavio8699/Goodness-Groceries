import SwiftUI
import SDWebImageSwiftUI

struct ProductRowView: View {
    
    let product: Product
    let hideSeparator: Bool
    
    var body: some View {
        VStack (spacing: 0) {
            HStack (alignment: .top) {
                WebImage(url: URL(string: product.imageURL)).resizable().frame(width: 100, height: 100).clipShape(Circle())
                VStack (alignment: .leading, spacing: 15) {
                    Text(product.name).bold()
                    //Text("indicators: \(product.indicators)")
                }.padding()
                Spacer()
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
