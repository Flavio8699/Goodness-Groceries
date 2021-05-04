import Foundation
import SwiftUI

class WelcomeViewModel: ObservableObject {
    
    static var selectedProductCategories = [String]()
    static var selectedIndicatorCategories = [String]()
    
    func requestAccess() {
        NetworkManager.shared.requestUserAccess(for: UserSettings.shared.clientID, product_categories: WelcomeViewModel.selectedProductCategories, indicator_categories: WelcomeViewModel.selectedIndicatorCategories) { result in
            switch result {
                case .success(_):
                    UserSettings.shared.step += 1
                    UserSettings.shared.statusRequested = true
                    break
                    
                case .failure(let type):
                    appDelegate().popupManager.currentPopup = .error(type)
                    break
            }
        }
    }
}
