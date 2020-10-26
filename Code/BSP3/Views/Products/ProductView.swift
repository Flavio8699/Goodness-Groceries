import SwiftUI
import SDWebImageSwiftUI
import MapKit

struct ProductView: View {
    
    let product: Product
    @ObservedObject var productsVM = ProductsViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.623874, longitude: 6.052060), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (alignment: .leading, spacing: 15) {
                Text(product.name).font(.title).bold()
                HStack (alignment: .top) {
                    WebImage(url: URL(string: product.image_url)).resizable().frame(width: 100, height: 100).cornerRadius(7)
                    Text(product.description).multilineTextAlignment(.leading).lineLimit(nil)
                }
                HStack(alignment: .top, spacing: 15) {
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Type").bold()
                        Text("Fournisseur").bold()
                    }
                    VStack (alignment: .leading, spacing: 15) {
                        Text(product.type)
                        Text(product.provider)
                    }
                    Spacer()
                }
                Map(coordinateRegion: $region).frame(height: 150).cornerRadius(7)
                Text("Indicateurs").font(.title2).bold()
                ForEach(product.indicators, id: \.self) { productIndicator in
                    if let indicator = productsVM.indicators.first(where: { $0.id == productIndicator.indicator_id }) {
                        HStack (alignment: .top, spacing: 15) {
                            Image(indicator.icon_name)
                            Text(productIndicator.indicator_description)
                            Spacer()
                        }
                        if productIndicator != product.indicators.last {
                            Divider()
                        }
                    }
                }
            }
            .padding()
            .navigationBarTitle("Produit")
            .navigationBarItems(trailing:
                Button(action: {
                    
                }, label: {
                    Text("Comparer")
                })
            )
        }
    }
}
