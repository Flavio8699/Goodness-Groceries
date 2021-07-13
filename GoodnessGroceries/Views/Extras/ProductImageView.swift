import SwiftUI
import SDWebImageSwiftUI

struct ProductImageView: View {
    
    private let url: String
    private let width: CGFloat
    private let height: CGFloat
    private let cornerRadius: CGFloat
    
    init(url: String, width: CGFloat = 100, height: CGFloat = 100, cornerRadius: CGFloat = 7) {
        self.url = url
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        ZStack {
            /*Image("placeholder").resizable().frame(width: width, height: height).cornerRadius(cornerRadius).redacted(reason: .placeholder)
            WebImage(url: URL(string: url)).resizable().frame(width: width, height: height).cornerRadius(cornerRadius)*/
            Image(url).resizable().frame(width: width, height: height).cornerRadius(cornerRadius)
        }
    }
}
