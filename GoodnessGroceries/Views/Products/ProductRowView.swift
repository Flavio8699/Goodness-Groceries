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
            HStack {
                ProductImageView(url: product.image_url)
                DottedLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                    .frame(width: 1, height: 100)
                    .foregroundColor(Color(.systemGray3))
                IndicatorIconsView(indicators: product.getIndicators(for: category))
            }
        }
        .padding(.vertical, 5)
    }
}

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}
