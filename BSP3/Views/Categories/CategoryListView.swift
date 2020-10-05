import SwiftUI

struct CategoryListView: View {
    
    let categories:[Category] = [
        Category(name: "Socio-Ecologique", indicators: [1,4]),
        Category(name: "Socio-Economique", indicators: [3]),
        Category(name: "Socio-Culturel", indicators: [5]),
        Category(name: "Socio-Politique", indicators: [4])
    ]
    
    var body: some View {
        ForEach(self.categories) { category in
            NavigationLink(destination: ProductsListView(category: category)) {
                CategoryRowView(category: category, hideSeparator: (category == self.categories.last)).foregroundColor(.black)
            }
        }
    }
}
