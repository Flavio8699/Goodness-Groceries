import Foundation

struct UserStatus: Decodable {
    var status: Status
    
    enum Status: String, Codable {
        case valid = "valid"
        case requested = "requested"
    }
}
