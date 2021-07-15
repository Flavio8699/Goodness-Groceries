import SwiftUI
import UIKit

struct Accueil: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @State var search: String = ""
    @State var isSearching: Bool = false
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                HStack {
                    Image("GG-Logo-2").resizable().frame(width: 70, height: 70)
                    HStack { TextField(NSLocalizedString("SEARCH", lang: UserSettings.language), text: $search, onCommit: {
                        isSearching = false
                    }) }
                    .padding(.leading, 26)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray5))
                    .cornerRadius(6)
                    .padding(.leading, 8)
                    .onTapGesture {
                        isSearching = true
                    }
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Spacer()
                            
                            if(search != "") {
                                Button(action: {
                                    search = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .foregroundColor(.gray)
                    )
                    .transition(.move(edge: .trailing))
                    .animation(.spring())
                    
                    if isSearching {
                        Button(action: {
                            isSearching = false
                            search = ""
                            
                            hideKeyboard()
                        }) {
                            Text(NSLocalizedString("CANCEL", lang: UserSettings.language)).foregroundColor(Color("GG_D_Blue"))
                        }
                        .transition(.move(edge: .trailing))
                    }
                }.padding(.horizontal).padding(.bottom, 5)
                Divider()
                ScrollView (.vertical, showsIndicators: true) {
                    if(search != "") {
                        let productsFiltered = productsVM.products.filter { NSLocalizedString($0.name, lang: UserSettings.language).lowercased().contains(search.lowercased()) }
                        
                        SearchView(products: productsFiltered).padding(.horizontal).animation(.linear)
                    } else {
                        CategoryListView().padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
