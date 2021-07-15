import SwiftUI

struct ProductView: View {
    
    let product: Product
    let category: Category?
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var productsVM = ProductsViewModel()
    @State private var showMore: Bool = false
    @State private var showCompare: Bool = false
    
    var body: some View {
        ScrollView (.vertical) {
            ScrollViewReader { value in
                VStack (alignment: .leading, spacing: 12) {
                    HStack (alignment: .top, spacing: 15) {
                        ProductImageView(url: product.image_url).onTapGesture {
                            PopupManager.currentPopup = .productImage(image: product.image_url)
                        }
                        Text(NSLocalizedString(product.name, lang: UserSettings.language)).font(.title).bold().fixedSize(horizontal: false, vertical: true)
                    }
                    Text(NSLocalizedString(product.description, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                    Divider()
                    HStack (spacing: 15) {
                        VStack (alignment: .leading, spacing: 12) {
                            HStack (alignment: .top) {
                                HStack {
                                    Text(NSLocalizedString("TYPE", lang: UserSettings.language)).bold()
                                    Spacer()
                                }.frame(width: 120)
                                Text(NSLocalizedString(product.type, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            HStack (alignment: .top) {
                                HStack {
                                    Text(NSLocalizedString("PROVIDER", lang: UserSettings.language)).bold()
                                    Spacer()
                                }.frame(width: 120)
                                Text(product.provider).fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                            HStack (alignment: .top) {
                                HStack {
                                    Text(NSLocalizedString("CATEGORY", lang: UserSettings.language)).bold()
                                    Spacer()
                                }.frame(width: 120)
                                Text(NSLocalizedString(product.category.description, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                        }
                        Spacer(minLength: 0)
                        Image("GG_\(product.category.rawValue)")
                    }
                    Divider()
                    Text(NSLocalizedString("INDICATORS", lang: UserSettings.language)).font(.title2).bold()
                    let indicators = product.getIndicators(for: category)
                    ForEach(indicators, id: \.self) { indicator in
                        if let productIndicator = product.indicators.first(where: { $0.id == indicator.id }) {
                            if productIndicator.applicable && productIndicator.sub_indicators.count > 0 {
                                ProductIndicatorRowView(productIndicator: productIndicator).id(indicator.id)
                            }
                        }
                    }
                    let otherIndicators = product.getIndicators(except: category)
                    if category != nil && otherIndicators.count > 0 {
                        Button(action: {
                            withAnimation(.linear(duration: 0.15)) {
                                showMore.toggle()
                            }
                        }, label: {
                            HStack {
                                Text(NSLocalizedString(showMore ? "SHOW_LESS" : "SHOW_MORE", lang: UserSettings.language))
                                Spacer()
                                Image("arrow_right").rotationEffect(.degrees(showMore ? 90 : 0))
                            }
                        })
                        if showMore {
                            ForEach(otherIndicators, id: \.self) { indicator in
                                if let productIndicator = product.indicators.first(where: { $0.id == indicator.id }) {
                                    if productIndicator.applicable && productIndicator.sub_indicators.count > 0 {
                                        ProductIndicatorRowView(productIndicator: productIndicator).id(indicator.id)
                                    }
                                }
                            }.onAppear {
                                withAnimation(.default) {
                                    value.scrollTo(otherIndicators.last?.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                    let similarProducts = product.getSimilarProducts()
                    if similarProducts.count > 0 {
                        Text(NSLocalizedString("SIMILAR_PRODUCTS", lang: UserSettings.language)).font(.title2).bold()
                        ScrollView (.horizontal) {
                            HStack {
                                ForEach(similarProducts, id: \.self) { similarProduct in
                                    NavigationLink(destination: ProductView(product: similarProduct, category: nil)) {
                                        ProductScannedView(product: similarProduct).frame(width: 280).foregroundColor(.black).padding([.bottom, .trailing])
                                    }
                                }
                            }
                        }
                    }
                    NavigationLink("", destination: CompareView(products: product.getCompareProducts()), isActive: $showCompare).hidden()
                }.padding()
            }
            .navigationBarTitle(NSLocalizedString("PRODUCT", lang: UserSettings.language))
            .navigationBarItems(trailing:
                Button(action: {
                    showCompare = true
                }, label: {
                    Text(NSLocalizedString("COMPARE", lang: UserSettings.language))
                })
            )
        }
    }
}
