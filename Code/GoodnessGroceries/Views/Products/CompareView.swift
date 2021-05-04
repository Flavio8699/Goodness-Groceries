import SwiftUI

struct CompareView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    let products: [Product]
    
    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width*0.2125 // 85% of the width for the 4 columns -> 85/(4*100%)=0.2125, 15% for the indicator column
            VStack (alignment: .leading, spacing: 0) {
                HStack (alignment: .top, spacing: 0) {
                    Spacer(minLength: 0)
                    Text("").frame(width: 40, height: 40)
                    Spacer(minLength: 0)
                    ForEach(products, id: \.self) { product in
                        Divider()
                        VStack (spacing: 10) {
                            ProductImageView(url: product.image_url, width: cellWidth-20, height: cellWidth-20).padding(.top, 10)
                            Text(product.name)
                            Spacer(minLength: 0)
                        }.padding(.horizontal, 5).frame(width: cellWidth, height: cellWidth*2)
                    }
                }.frame(height: cellWidth*2)
                Divider()
                ScrollView (.vertical, showsIndicators: true) {
                    ForEach(productsVM.indicators) { ind in
                        HStack (spacing: 0) {
                            HStack (spacing: 0) {
                                Spacer(minLength: 0)
                                Image(ind.icon_name)
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .padding(.vertical, 10)
                                Spacer(minLength: 0)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                PopupManager.currentPopup = .indicator(indicator: ind)
                                impactFeedback(.medium)
                            }
                            ForEach(products, id: \.self) { product in
                                let contains = product.getIndicators().contains(ind)
                                Divider()
                                Image(systemName: contains ? "checkmark" : "xmark").frame(width: cellWidth).font(Font.system(size: 20, weight: .bold)).opacity(contains ? 1 : 0.4)
                            }
                        }
                        Divider()
                    }
                }
            }
            .navigationTitle(NSLocalizedString("COMPARE", lang: UserSettings.language))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
