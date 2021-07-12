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
                    DispatchQueue.main.async {
                        NetworkManager.shared.sendDeviceToken(for: UserSettings.shared.clientID, device_token: UserSettings.shared.deviceToken)
                    }
                    break
                    
                case .failure(let type):
                    appDelegate().popupManager.currentPopup = .error(type)
                    break
            }
        }
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        if(UserSettings.shared.clientID.count != 13) {
            completion(false)
        } else {
            completion(true)
        }
    }
}
