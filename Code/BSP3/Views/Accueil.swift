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
                HStack {
                    TextField("Rechercher", text: $search, onEditingChanged: {
                        if $0 {
                            withAnimation(.default) {
                                width = UIScreen.main.bounds.size.width*3/4-15
                            }
                            withAnimation(Animation.default.delay(0.25)) {
                                showCancelButton = true
                            }
                        } else {
                            hideKeyboard()
                            withAnimation(.default) {
                                search = ""
                                showCancelButton = false
                            }
                            withAnimation(Animation.default.delay(0.25)) {
                                width = .infinity
                            }
                        }
                    }).textFieldStyle(RoundedBorderTextFieldStyle()).frame(maxWidth: width)
                    if(showCancelButton) {
                        Spacer()
                        Button(action: {
                            hideKeyboard()
                            withAnimation(.default) {
                                search = ""
                                showCancelButton = false
                            }
                            withAnimation(Animation.default.delay(0.25)) {
                                width = .infinity
                            }
                        }, label: {
                            Text("Annuler")
                        })
                    }
                }
                if(search != "") {
                    let productsFiltered = productsVM.products.filter { $0.name.contains(search) }
                    SearchView(products: productsFiltered)
                } else {
                    ScrollView (.vertical, showsIndicators: false) {
                        CategoryListView()
                    }.padding(0).frame(maxHeight: .infinity)
                }
            }.padding([.horizontal, .top])
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
