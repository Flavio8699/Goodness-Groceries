import SwiftUI

struct CategoryListView: View {
    
    let categories:[Category] = [Category(name: "Socio-Ecologique"), Category(name: "Socio-Economique"), Category(name: "Socio-Culturel"), Category(name: "Socio-Politique")]
    
    var body: some View {
        ForEach(self.categories) { category in
            NavigationLink(destination: ProductsListView(category: category)) {
                CategoryCellView(category: category, hideSeparator: (category == self.categories.last)).foregroundColor(.black)
            }
        }
    }
}
