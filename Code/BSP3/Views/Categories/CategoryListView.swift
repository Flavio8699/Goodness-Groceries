import SwiftUI

struct CategoryListView: View {
    
    @StateObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(categoriesVM.categories, id: \.self) { category in
                VStack (alignment: .leading) {
                    NavigationLink(destination: ProductsListView(category: category)) {
                        HStack {
                            Text(category.name).font(.title).foregroundColor(.black)
                            Image("arrow_right").padding(.top, 4)
                            Spacer(minLength: 0)
                        }
                    }.border(Color.black, width: 1)
                    CategoryRowView(category: category, hideSeparator: (category == categoriesVM.categories.last)).foregroundColor(.black)
                }
            }
        }
    }
}
