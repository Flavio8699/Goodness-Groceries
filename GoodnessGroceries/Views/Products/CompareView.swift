import SwiftUI

struct CompareView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @StateObject var categoriesVM = CategoriesViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    let products: [Product]
    
    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width*0.2125 // 85% of the width for the 4 columns -> 85/(4*100%)=0.2125, 15% for the indicator column
            VStack (alignment: .leading, spacing: 0) {
                HStack (alignment: .top, spacing: 0) {
                    VStack (spacing: 0) {
                        Spacer(minLength: 0)
                        Text(NSLocalizedString("PRODUCT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true).frame(width: cellWidth*1.5)
                        Spacer(minLength: 0)
                    }.rotationEffect(.degrees( -90)).frame(width: geometry.size.width*0.15)
                    ForEach(products, id: \.self) { product in
                        Divider()
                        VStack (alignment: .leading, spacing: 10) {
                            ProductImageView(url: product.image_url, width: cellWidth-20, height: cellWidth-20).padding(.top, 10)
                                .onTapGesture {
                                PopupManager.currentPopup = .productImage(image: product.image_url)
                            }
                            Text(NSLocalizedString(product.name, lang: UserSettings.language)).font(.system(size: 12)).multilineTextAlignment(.center)
                            Spacer(minLength: 0)
                        }.padding(.horizontal, 5).frame(width: cellWidth, height: cellWidth*1.5)
                    }
                }.frame(height: cellWidth*1.5)
                Divider()
                ScrollView (.vertical, showsIndicators: true) {
                    VStack (alignment: .leading, spacing: 0) {
                        HStack (alignment: .top, spacing: 0) {
                            VStack (alignment: .leading, spacing: 0) {
                                Spacer(minLength: 0)
                                Text(NSLocalizedString("CATEGORY", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true).frame(width: cellWidth*1.5)
                                Spacer(minLength: 0)
                            }.rotationEffect(.degrees( -90)).frame(width: geometry.size.width*0.15)
                            ForEach(products, id: \.self) { product in
                                Divider()
                                VStack (alignment: .leading, spacing: 10) {
                                    Image("GG_\(product.category.rawValue)").resizable().scaledToFit().frame(width: cellWidth-20, height: cellWidth-20).padding(.top, 10)
                                    Text(NSLocalizedString(product.category.description, lang: UserSettings.language)).font(.system(size: 12)).multilineTextAlignment(.center)
                                    Spacer(minLength: 0)
                                }.padding(.horizontal, 5).frame(width: cellWidth, height: cellWidth*1.5)
                            }
                        }.frame(height: cellWidth*1.5)
                        Divider()
                        ForEach(categoriesVM.categories, id: \.self) { category in
                            HStack (spacing: 0) {
                                HStack (spacing: 0) {
                                    Spacer(minLength: 0)
                                    Image(category.icon_name)
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width*0.15-10, height: geometry.size.width*0.15-10)
                                        .padding(.vertical, 5)
                                    Spacer(minLength: 0)
                                }.frame(width: geometry.size.width*0.15)
                                Divider()
                                Text(NSLocalizedString(category.name, lang: UserSettings.language)).bold().padding(.leading)
                                Spacer()
                            }
                            Divider()
                            ForEach(category.getIndicators()) { indicator in
                                VStack (alignment: .leading, spacing: 0) {
                                    HStack (spacing: 0) {
                                        HStack (spacing: 0) {
                                            Spacer(minLength: 0)
                                            Image(indicator.icon_name)
                                                .renderingMode(.original)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geometry.size.width*0.15-10, height: geometry.size.width*0.15-10)
                                                .padding(.vertical, 5)
                                            Spacer(minLength: 0)
                                        }
                                        .frame(width: geometry.size.width*0.15)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            PopupManager.currentPopup = .indicator(indicator: indicator)
                                            impactFeedback(.medium)
                                        }
                                        ForEach(products, id: \.self) { product in
                                            switch product.hasIndicator(indicator: indicator) {
                                                case .yes:
                                                    Divider()
                                                    Image(systemName: "checkmark").foregroundColor(Color("GG_D_Green")).frame(width: cellWidth).font(Font.system(size: 20, weight: .bold))
                                                case .no:
                                                    Divider()
                                                    Text("Ø").frame(width: cellWidth).font(Font.system(size: 20, weight: .bold)).foregroundColor(Color(.systemRed))
                                                case .not_applicable:
                                                    if product == products.last {
                                                        Divider()
                                                        HStack (spacing: 0) {
                                                            Text(NSLocalizedString("NOT_APPLICABLE", lang: UserSettings.language))
                                                                .foregroundColor(Color(.systemGray))
                                                                .font(.system(size: 14))
                                                                .padding(.leading)
                                                            Spacer()
                                                        }.frame(width: cellWidth*4)
                                                    }
                                            }
                                        }
                                    }
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("COMPARE", lang: UserSettings.language))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
