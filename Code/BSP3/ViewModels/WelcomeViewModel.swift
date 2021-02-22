import Foundation
import SwiftUI
import Alamofire

class WelcomeViewModel: ObservableObject {
    
    private var NetworkManager = BSP3.NetworkManager()
    @Published var productCategories = [ProductCategoryWelcome]()
    static var selectedProductCategories = [String]()
    static var selectedIndicatorCategories = [String]()
    
    init() {
        self.productCategories = [
            ProductCategoryWelcome(name: "Conventionel importé", icon: "Conventionnel_Importé_Icon", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Conventionel local", icon: "Conventionnel_Local_Icon", color: Color("conventionelPink")),
            ProductCategoryWelcome(name: "Bio importé", icon: "Bio_Importé_Icon", color: Color("bioGreen")),
            ProductCategoryWelcome(name: "Bio local", icon: "Bio_Local_Icon", color: Color("bioGreen"))
        ]
    }
    
    func requestAccess(for clientID: String, completion: @escaping (Result<Void,AFError>) -> Void) {
        NetworkManager.requestUserAccess(for: clientID, product_categories: WelcomeViewModel.selectedProductCategories, indicator_categories: WelcomeViewModel.selectedIndicatorCategories) {
            completion($0)
        }
    }
}
