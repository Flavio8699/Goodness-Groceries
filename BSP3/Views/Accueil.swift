import SwiftUI

struct Accueil: View {
    
    @ObservedObject var productsVM = ProductsViewModel()
    @State var search: String = ""
    
    var body: some View {
        NavigationView {
            VStack (spacing: 15) {
                TextField("Rechercher", text: $search).textFieldStyle(RoundedBorderTextFieldStyle())
                if(self.search != "") {
                    ForEach(self.productsVM.products.filter {
                        self.search.isEmpty ? false : $0.name.contains(self.search)
                    }, id: \.self) { product in
                        Text(product.name)
                    }
                } else {
                    ScrollView (.vertical, showsIndicators: false) {
                        CategoryListView()
                    }.padding(0).frame(maxHeight: .infinity)
                }
            }.padding([.horizontal, .top])
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .onAppear {
            NetworkManager().fetchProductsBought {
                print($0)
            }
        }
    }
}
