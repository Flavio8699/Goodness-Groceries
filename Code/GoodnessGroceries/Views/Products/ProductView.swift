import SwiftUI

struct ProductView: View {
    
    let product: Product
    let category: Category?
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var productsVM = ProductsViewModel()
    @State private var showMore: Bool = false
    @State private var showCompare: Bool = false
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            ScrollViewReader { value in
                VStack (alignment: .leading, spacing: 12) {
                    Text(product.name).font(.title).bold()
                    HStack (alignment: .top, spacing: 15) {
                        ProductImageView(url: product.image_url)
                        Text(product.description).fixedSize(horizontal: false, vertical: true)
                    }
                    HStack(alignment: .top, spacing: 15) {
                        VStack (alignment: .leading, spacing: 12) {
                            Text(NSLocalizedString("TYPE", lang: UserSettings.language)).bold()
                            Text(NSLocalizedString("PROVIDER", lang: UserSettings.language)).bold()
                            Text(NSLocalizedString("CATEGORY", lang: UserSettings.language)).bold()
                        }
                        VStack (alignment: .leading, spacing: 12) {
                            Text(product.type)
                            Text(product.provider)
                            Text(NSLocalizedString(product.category.description, lang: UserSettings.language))
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            Image("GG-\(product.category.rawValue)")
                            Spacer()
                        }
                    }
                    Text(NSLocalizedString("INDICATORS", lang: UserSettings.language)).font(.title2).bold()
                    let indicators = product.getIndicators(for: category)
                    ForEach(indicators, id: \.self) { indicator in
                        ProductIndicatorRowView(indicator: indicator).id(indicator.id)
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
                                ProductIndicatorRowView(indicator: indicator).id(indicator.id)
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
                                        ProductScannedView(product: similarProduct).frame(width: 280).foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                    NavigationLink("", destination: CompareView(products: Array(Set(arrayLiteral: product).union(similarProducts))), isActive: $showCompare).hidden()
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
