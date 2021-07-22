import Foundation
import Alamofire
import SwiftyJSON

let Alamofire: Session = {
    let configuration = URLSessionConfiguration.af.default
    configuration.waitsForConnectivity = false
    return Session(configuration: configuration)
}()

class Connectivity {
    class var connected: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    let BASE_URL: String = "https://goodnessgroceries.com/"
    
    func requestUserAccess(for participant_id: String, product_categories: [String], indicator_categories: [String], completion: @escaping (Result<UserStatus,PopupErrorType>) -> Void) {
        if !Connectivity.connected {
            completion(.failure(.network))
            return;
        }
        UserSettings.shared.loading = true
        
        let parameters: [String: Any] = [
            "participant_id": participant_id,
            "platform": "ios",
            "product_category_1": product_categories.count > 0 ? product_categories[0] : "",
            "product_category_2": product_categories.count > 1 ? product_categories[1] : "",
            "product_category_3": product_categories.count > 2 ? product_categories[2] : "",
            "product_category_4": product_categories.count > 3 ? product_categories[3] : "",
            "indicator_category_1": indicator_categories.count > 0 ? indicator_categories[0] : "",
            "indicator_category_2": indicator_categories.count > 1 ? indicator_categories[1] : "",
            "indicator_category_3": indicator_categories.count > 2 ? indicator_categories[2] : "",
            "indicator_category_4": indicator_categories.count > 3 ? indicator_categories[3] : ""
        ]
        
        Alamofire.request(BASE_URL + "request_user_access/", method: .post, parameters: parameters).validate().responseJSON { response in
            UserSettings.shared.loading = false
            switch response.result {
                case .success(_):
                    let json = JSON(response.data!)
                    let status = UserStatus(rawValue: json["status"].rawValue as! String)!
                    completion(.success(status))
                    break
                    
                case .failure(_):
                    completion(.failure(.general))
                    break
            }
        }
    }
    
    func fetchUserStatus(for participant_id: String, completion: @escaping (Result<UserStatus,PopupErrorType>) -> Void) {
        if !Connectivity.connected {
            completion(.failure(.network))
            return;
        }
        
        Alamofire.request(BASE_URL + "fetch_user_status/\(participant_id)/", method: .get).validate().responseJSON { response in
            switch response.result {
                case .success(_):
                    let json = JSON(response.data!)
                    let status = UserStatus(rawValue: json["status"].rawValue as! String)!
                    completion(.success(status))
                    break
                    
                case .failure(_):
                    completion(.failure(.general))
                    break
            }
        }
    }
    
    func fetchProductsBought(for participant_id: String, completion: @escaping (Result<[ProductBought]?,AFError>) -> Void) {
        Alamofire.request(BASE_URL + "get_bought_products/\(participant_id)/", method: .get).validate().responseData { response in
            switch response.result {
                case .success(_):
                    do {
                        let products = try JSONDecoder().decode([ProductBought].self, from: response.data!)
                        completion(.success(products))
                    } catch {
                        print("Error while decoding JSON response")
                    }
                    break
                    
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
    
    func sendProductFeedback(for participant_id: String, product_ean: String, selected_indicator_main_id: String, selected_indicator_secondary_id: String, free_text_indicator: String, price_checkbox_selected: Bool, completion: @escaping (Result<Void,PopupErrorType>) -> Void) {
        if !Connectivity.connected {
            completion(.failure(.network))
            return;
        }
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = format.string(from: date)
        
        let parameters: [String: Any] = [
            "participant": participant_id,
            "product_ean": product_ean,
            "timestamp": timestamp,
            "selected_indicator_main_id": selected_indicator_main_id,
            "selected_indicator_secondary_id": selected_indicator_secondary_id,
            "free_text_indicator": free_text_indicator,
            "price_checkbox_selected": price_checkbox_selected
        ]
        
        Alamofire.request(BASE_URL + "post_product_review/", method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
                case .success(_):
                    completion(.success(()))
                    break
                    
                case .failure(_):
                    completion(.failure(.general))
                    break
            }
        }
    }
    
    func sendDeviceToken(for participant_id: String, device_token: String) {
        
        let parameters: [String: Any] = [
            "name": participant_id,
            "registration_id": device_token
        ]
        
        Alamofire.request(BASE_URL + "device/apns/", method: .post, parameters: parameters).validate().responseJSON { _ in }
    }
}
