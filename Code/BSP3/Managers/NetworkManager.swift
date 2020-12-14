import Foundation

class NetworkManager: ObservableObject {
    
    private let config = URLSessionConfiguration.default
    
    init() {
        config.waitsForConnectivity = true
    }
    
    func requestUserAccess(for participant_id: String) {
        var request = URLRequest(url: URL(string: "https://goodnessgroceries.com/request_user_access/")!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "participant_id": participant_id,
            "product_category_1": "test1",
            "product_category_2": "test2",
            "product_category_3": "test3",
            "product_category_4": "test4"
        ]
        request.httpBody = parameters.percentEncoded()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }
        }.resume()
    }
    
    func fetchUserStatus(for participant_id: String, completion: @escaping (Result<UserStatus,ResultError>) -> Void) {
        let request = URLRequest(url: URL(string: "https://goodnessgroceries.com/fetch_user_status/\(participant_id)/")!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.NetworkError))
                }
                return
            }
            let json = try? JSONDecoder().decode(UserStatus.self, from: data!)
            DispatchQueue.main.async {
                completion(.success(json!))
            }
        }.resume()
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
