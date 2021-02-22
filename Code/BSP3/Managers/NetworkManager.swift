import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class NetworkManager: ObservableObject {
    
    private let config = URLSessionConfiguration.default
    
    init() {
        config.waitsForConnectivity = true
    }
    
    func checkInternet(showLoader: Bool = true, completionHandler: @escaping (_ internet:Bool) -> Void)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        let url = URL(string: "http://www.google.com/")
        var req = URLRequest.init(url: url!)
        req.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        req.timeoutInterval = 10.0

        
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil  {
                completionHandler(false)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                } else {
                    completionHandler(false)
                }
            }
        }
        task.resume()
      }
    
    func requestUserAccess(for participant_id: String, product_categories: [String], indicator_categories: [String], completion: @escaping (Result<Void,AFError>) -> Void) {
        
        let parameters: [String: Any] = [
            "participant_id": participant_id,
            "product_category_1": product_categories.count > 0 ? product_categories[0] : "null",
            "product_category_2": product_categories.count > 1 ? product_categories[1] : "null",
            "product_category_3": product_categories.count > 2 ? product_categories[2] : "null",
            "product_category_4": product_categories.count > 3 ? product_categories[3] : "null",
            "indicator_category_1": indicator_categories.count > 0 ? indicator_categories[0] : "null",
            "indicator_category_2": indicator_categories.count > 1 ? indicator_categories[1] : "null",
            "indicator_category_3": indicator_categories.count > 2 ? indicator_categories[2] : "null",
            "indicator_category_4": indicator_categories.count > 3 ? indicator_categories[3] : "null"
        ]
        
        AF.request("https://goodnessgroceries.com/request_user_access/", method: .post, parameters: parameters).validate().responseJSON { response in
            switch response.result {
                case .success(_):
                    completion(.success(()))
                    break
                    
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
    
    func fetchUserStatus(for participant_id: String, completion: @escaping (Result<UserStatus,AFError>) -> Void) {
        AF.request("https://goodnessgroceries.com/fetch_user_status/\(participant_id)/", method: .get).validate().responseJSON { response in
            switch response.result {
                case .success(_):
                    let json = JSON(response.data!)
                    let status = UserStatus(rawValue: json["status"].rawValue as! String)!
                    completion(.success(status))
                    break
                    
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
    
    func fetchProductsBought(completion: @escaping ([ProductBought]?) -> Void) {
        let request = URLRequest(url: URL(string: "https://flavio8699.github.io/Goodness-Groceries/tickets_caisse.json")!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let json = try? JSONDecoder().decode([ProductBought].self, from: data!)
            DispatchQueue.main.async {
                completion(json)
            }
        }.resume()
    }
}
