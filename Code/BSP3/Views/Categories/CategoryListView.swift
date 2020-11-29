import SwiftUI

struct CategoryListView: View {
    
    @StateObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(categoriesVM.categories, id: \.self) { category in
                NavigationLink(destination: ProductsListView(category: category)) {
                    CategoryRowView(category: category, hideSeparator: (category == categoriesVM.categories.last)).foregroundColor(.black)
                }
            }
        }
    }
}
