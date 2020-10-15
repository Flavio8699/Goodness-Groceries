import SwiftUI
import SDWebImageSwiftUI

struct ProductScannedView: View {
    
    let product: Product
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: product.image_url)).resizable().frame(width: 80, height: 80).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                VStack (alignment: .leading) {
                    Text(product.name).bold().font(.system(size: 18))
                    Text(product.description).lineLimit(2).font(.system(size: 16))
                }
                Spacer()
            }
            .padding()
            .background(Color(.white))
            .foregroundColor(.black)
            .cornerRadius(6)
        }.padding(.horizontal, 20)
        .shadow(color: Color.black.opacity(0.6), radius: 4, x: 3, y: 3)
    }
}
