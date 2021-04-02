import Foundation
import SwiftUI

class WelcomeViewModel: ObservableObject {
    
    private var NetworkManager = GoodnessGroceries.NetworkManager()
    @Published var productCategories = [ProductCategoryWelcome]()
    static var selectedProductCategories = [String]()
    static var selectedIndicatorCategories = [String]()
    
    init() {
        self.productCategories = [
            ProductCategoryWelcome(name: "Conventionel importé", icon: "GG-ImportedConventional", color: Color("GG_L_Green")),
            ProductCategoryWelcome(name: "Conventionel local", icon: "GG-LocalConventional", color: Color("GG_L_Green")),
            ProductCategoryWelcome(name: "Bio importé", icon: "GG-ImportedOrganic", color: Color("GG_L_Green")),
            ProductCategoryWelcome(name: "Bio local", icon: "GG-LocalOrganic", color: Color("GG_L_Green"))
        ]
    }
    
    func requestAccess(for userS: UserSettings) {
        NetworkManager.requestUserAccess(for: userS.clientID, product_categories: WelcomeViewModel.selectedProductCategories, indicator_categories: WelcomeViewModel.selectedIndicatorCategories) { result in
            switch result {
                case .success(_):
                    userS.step += 1
                    userS.statusRequested = true
                    break
                    
                case .failure(let type):
                    appDelegate().popupManager.currentPopup = .error(type)
                    break
            }
        }
    }
}
