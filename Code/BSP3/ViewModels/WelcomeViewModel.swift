import Foundation
import SwiftUI

class WelcomeViewModel: ObservableObject {
    @Published var productCategories = [ProductCategoryWelcome]()
    @Published var categories = [CategoryWelcome]()
    
    init() {
        self.productCategories = [
            ProductCategoryWelcome(name: "Conventionel importé", icon: "Conventionnel_Importé_Icon", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Conventionel local", icon: "Conventionnel_Local_Icon", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Bio importé", icon: "Bio_Importé_Icon", color: Color("bioGreen")),
            ProductCategoryWelcome(name: "Bio local", icon: "Bio_Local_Icon", color: Color("bioGreen"))
        ]
        
        self.categories = [
            CategoryWelcome(name: "ind_cat_economic", description: "Soutenir les producteurs au juste prix", icon: "Socio-Economique", color: Color("wc_yellow")),
            CategoryWelcome(name: "ind_cat_social", description: "Connaître les lois qui régissent une filière", icon: "Socio-Ecologique", color: Color("wc_green")),
            CategoryWelcome(name: "ind_cat_environment", description: "Encourager une production équitable", icon: "Socio-Culturel", color: Color("wc_orange")),
            CategoryWelcome(name: "ind_cat_governance", description: "Privilégier des méthodes agricoles éthiques", icon: "Socio-Politique", color: Color("wc_blue"))
        ]
    }
    
}
