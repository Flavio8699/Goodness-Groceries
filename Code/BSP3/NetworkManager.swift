import Foundation

class NetworkManager {
    
    func fetchProductsBought(completion: @escaping ([ProductBought]?) -> Void) {
        let request = URLRequest(url: URL(string: "https://flavio8699.github.io/GreenBot/tickets_caisse.json")!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                let json = try? JSONDecoder().decode([ProductBought].self, from: data!)
                DispatchQueue.main.async {
                    completion(json)
                }
        }.resume()
    }
}
