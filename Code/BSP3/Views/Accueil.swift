import SwiftUI
import UIKit
struct Accueil: View {
    
    @ObservedObject var productsVM = ProductsViewModel()
    @State var search: String = ""
    @State var width: CGFloat = .infinity
    @State var showCancelButton: Bool = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 15) {
                VStack {
                    HStack (spacing: 12) {
                        Image(systemName: "magnifyingglass")
                        TextField("Rechercher", text: $search)
                    }.padding(.vertical, 10).padding(.horizontal)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
                )
                .padding([.horizontal, .top])
                if(search != "") {
                    let productsFiltered = productsVM.products.filter { $0.name.contains(search) }
                    SearchView(products: productsFiltered).padding(.horizontal)
                } else {
                    ScrollView (.vertical, showsIndicators: false) {
                        CategoryListView()
                    }.padding(.horizontal).frame(maxHeight: .infinity)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct SearchView: View {
    let products: [Product]
    
    var body: some View {
        ForEach(products, id: \.self) { product in
            Text(product.name).animation(Animation.default)
        }
        Spacer()
    }
}
