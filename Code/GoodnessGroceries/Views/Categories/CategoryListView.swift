import SwiftUI

struct CategoryListView: View {
    
    @StateObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(categoriesVM.categories, id: \.self) { category in
                CategoryRowView(category: category).foregroundColor(.black)
                if category != categoriesVM.categories.last {
                    Divider()
                }
            }
        }
    }
}
