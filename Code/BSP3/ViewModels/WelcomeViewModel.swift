import Foundation
import SwiftUI

class WelcomeViewModel: ObservableObject {
    @Published var categories = [ProductCategoryWelcome]()
    
    init() {
        self.categories = [
            ProductCategoryWelcome(name: "Conventionel importé", icon: "Welcome_Icon1", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Conventionel local", icon: "Welcome_Icon1", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Bio importé", icon: "Welcome_Icon2", color: Color("bioGreen")),
            ProductCategoryWelcome(name: "Bio local", icon: "Welcome_Icon2", color: Color("bioGreen"))
        ]
    }
    
}
