import Foundation

class CategoriesViewModel: ObservableObject {
    @Published var categories = [Category]()
    
    init() {
        self.categories = loadJson("indicator_categories.json")
    }
    
}
