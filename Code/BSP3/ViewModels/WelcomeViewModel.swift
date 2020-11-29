import Foundation
import SwiftUI

class WelcomeViewModel: ObservableObject {
    @Published var productCategories = [ProductCategoryWelcome]()
    
    init() {
        self.productCategories = [
            ProductCategoryWelcome(name: "Conventionel importé", icon: "Conventionnel_Importé_Icon", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Conventionel local", icon: "Conventionnel_Local_Icon", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Bio importé", icon: "Bio_Importé_Icon", color: Color("bioGreen")),
            ProductCategoryWelcome(name: "Bio local", icon: "Bio_Local_Icon", color: Color("bioGreen"))
        ]
    }
    
}
