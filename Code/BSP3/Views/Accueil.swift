import SwiftUI
import UIKit

struct Accueil: View {
    
    @StateObject var productsVM = ProductsViewModel()
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
                        if search != "" {
                            Spacer(minLength: 0)
                            Button(action: {
                                withAnimation(.default) {
                                    search = ""
                                    hideKeyboard()
                                }
                            }, label: {
                                Image(systemName: "xmark.circle").foregroundColor(.gray)
                            }).transition(.fade)
                        }
                    }.padding(.vertical, 10).padding(.horizontal)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.black.opacity(0.3), lineWidth: 0.5)
                )
                .padding([.horizontal, .top])
                if(search != "") {
                    let productsFiltered = productsVM.products.filter { $0.name.lowercased().contains(search.lowercased()) }
                    ScrollView (.vertical, showsIndicators: false) {
                        SearchView(products: productsFiltered)
                    }.padding(.horizontal).frame(maxHeight: .infinity)
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
