import SwiftUI

struct CategoryListView: View {
    
    @StateObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        VStack (spacing: 0) {
            ForEach(categoriesVM.categories, id: \.self) { category in
                CategoryRowView(category: category).foregroundColor(.black)
                Divider()
            }
        }
    }
}
