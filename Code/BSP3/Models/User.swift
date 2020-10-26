import Foundation

class User: Decodable {
    var name: String
    var xp: Int
    var showWelcome: Bool
}

struct UserStatus: Decodable {
    var status: Status
    
    enum Status: String, Codable {
        case valid = "valid"
        case requested = "requested"
    }
}
