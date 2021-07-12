import SwiftUI

struct ProductCategoryListView: View {
    
    let category: Category
    @StateObject var categoriesVM = CategoriesViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack {
                ForEach(ProductCategory.allCases, id: \.self) { product_category in
                    NavigationLink(destination: ProductListView(category: category, product_category: product_category)) {
                        ProductCategoryRowView(product_category: product_category).foregroundColor(.black)
                    }
                    Divider()
                }
            }.padding(.horizontal).padding(.top, 5)
        }
    }
}
