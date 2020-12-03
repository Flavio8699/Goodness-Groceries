import SwiftUI
import SDWebImageSwiftUI
import MapKit

enum ActiveSheet: Identifiable {
    case indicators, map
    
    var id: Int {
        hashValue
    }
}

struct ProductView: View {
    
    let product: Product
    let category: Category?
    @StateObject var productsVM = ProductsViewModel()
    @State private var activeSheet: ActiveSheet?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.623874, longitude: 6.052060), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (alignment: .leading, spacing: 15) {
                Text(product.name).font(.title).bold()
                HStack (spacing: 15) {
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
                        HStack {
                            Text(product.provider)
                            Button(action: {
                                activeSheet = .map
                            }, label: {
                                Text("(voir sur la carte)")
                            })
                        }
                    }
                    Spacer()
                }
                HStack {
                    Text("Indicateurs").font(.title2).bold()
                    if category != nil {
                        Spacer()
                        Button(action: {
                            activeSheet = .indicators
                        }, label: {
                            Text("Voir plus")
                        })
                    }
                }
                ForEach(product.indicators, id: \.self) { productIndicator in
                    if let indicator = productsVM.indicators.first(where: { $0.id == productIndicator.indicator_id }) {
                        if let category = category {
                            if indicator.category_id == category.id {
                                HStack (spacing: 15) {
                                    Image(indicator.icon_name)
                                    Text(productIndicator.indicator_description)
                                    Spacer(minLength: 0)
                                }
                                Divider()
                            }
                        } else {
                            HStack (spacing: 15) {
                                Image(indicator.icon_name)
                                Text(productIndicator.indicator_description)
                                Spacer(minLength: 0)
                            }
                            Divider()
                        }
                    }
                }
            }
            .padding()
            .sheet(item: $activeSheet) { item in
                if item == .indicators {
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Indicateurs").font(.title).bold()
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(product.indicators, id: \.self) { productIndicator in
                                if let indicator = productsVM.indicators.first(where: { $0.id == productIndicator.indicator_id }) {
                                    HStack (spacing: 15) {
                                        Image(indicator.icon_name)
                                        Text(productIndicator.indicator_description).fixedSize(horizontal: false, vertical: true)
                                        Spacer(minLength: 0)
                                    }
                                    if productIndicator != product.indicators.last {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }.padding()
                    Spacer()
                } else if item == .map {
                    ZStack (alignment: .bottom) {
                        Map(coordinateRegion: $region).frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
                        BlueButton(label: "Fermer", action: {
                            activeSheet = nil
                        }).padding().offset(y: -25)
                    }
                }
            }
            .navigationBarTitle("Produit")
            /*.navigationBarItems(trailing:
                Button(action: {
                    
                }, label: {
                    Text("Comparer")
                })
            )*/
        }
    }
}
