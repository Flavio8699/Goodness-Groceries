import SwiftUI
import SDWebImageSwiftUI

struct ProductView: View {
    
    let product: Product
    let category: Category?
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var productsVM = ProductsViewModel()
    @State private var sheetOpen: Bool = false

    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            VStack (alignment: .leading, spacing: 15) {
                Text(product.name).font(.title).bold()
                HStack (alignment: .top, spacing: 15) {
                    WebImage(url: URL(string: product.image_url)).resizable().frame(width: 100, height: 100).cornerRadius(7)
                    Text(product.description).fixedSize(horizontal: false, vertical: true)
                }
                HStack(alignment: .top, spacing: 15) {
                    VStack (alignment: .leading, spacing: 15) {
                        Text(NSLocalizedString("TYPE", lang: UserSettings.language)).bold()
                        Text(NSLocalizedString("PROVIDER", lang: UserSettings.language)).bold()
                    }
                    VStack (alignment: .leading, spacing: 15) {
                        Text(product.type)
                        Text(product.provider)
                    }
                    Spacer()
                }
                HStack {
                    Text(NSLocalizedString("INDICATORS", lang: UserSettings.language)).font(.title2).bold()
                    if category != nil {
                        Spacer()
                        Button(action: {
                            sheetOpen.toggle()
                        }, label: {
                            Text(NSLocalizedString("SHOW_MORE", lang: UserSettings.language))
                        })
                    }
                }
                let indicators = product.getIndicators(for: category)
                ForEach(indicators, id: \.self) { indicator in
                    HStack (spacing: 15) {
                        Image(indicator.icon_name)
                        Text(indicator.product_description ?? "").fixedSize(horizontal: false, vertical: true)
                        Spacer(minLength: 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        PopupManager.currentPopup = .indicator(indicator: indicator)
                        impactFeedback(.medium)
                    }
                    if indicator != indicators.last {
                        Divider()
                    }
                }
            }
            .padding()
            .sheet(isPresented: $sheetOpen) {
                VStack (alignment: .leading, spacing: 15) {
                    Text(NSLocalizedString("INDICATORS", lang: UserSettings.language)).font(.title).bold()
                    ScrollView(.vertical, showsIndicators: false) {
                        let indicators = product.getIndicators()
                        ForEach(indicators, id: \.self) { indicator in
                            HStack (spacing: 15) {
                                Image(indicator.icon_name)
                                Text(indicator.product_description ?? "").fixedSize(horizontal: false, vertical: true)
                                Spacer(minLength: 0)
                            }
                            if indicator != indicators.last {
                                Divider()
                            }
                        }
                    }
                }.padding()
                Spacer()
            }
            .navigationBarTitle(NSLocalizedString("PRODUCT", lang: UserSettings.language))
            .navigationBarItems(trailing:
                Button(action: {
                    
                }, label: {
                    Text("Comparer")
                })
            )
        }
    }
}
