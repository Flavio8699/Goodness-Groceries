import SwiftUI

struct CategoryIconsGridView: View {
    
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var categoriesVM = CategoriesViewModel()
    let scale: CGFloat = 0.7
    let padding: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width/2
            let cellHeight = geometry.size.height/2 - 2 * padding
            
            VStack (spacing: 0) {
                HStack (spacing: 0) {
                    ForEach(categoriesVM.categories[0...1], id: \.self) { category in
                        VStack (spacing: 0) {
                            Image(category.icon_name).resizable().scaledToFit().frame(height: cellHeight * scale)
                        }.frame(width: cellWidth, height: cellHeight)
                        .onTapGesture {
                            PopupManager.currentPopup = .category(category: category)
                            impactFeedback(.medium)
                        }
                    }
                }.padding(.vertical, padding)
                HStack (spacing: 0) {
                    ForEach(categoriesVM.categories[2...3], id: \.self) { category in
                        VStack (spacing: 0) {
                            Image(category.icon_name).resizable().scaledToFit().frame(height: cellHeight * scale)
                        }.frame(width: cellWidth, height: cellHeight)
                        .onTapGesture {
                            PopupManager.currentPopup = .category(category: category)
                            impactFeedback(.medium)
                        }
                    }
                    
                }.padding(.vertical, padding)
            }
        }
    }
}
