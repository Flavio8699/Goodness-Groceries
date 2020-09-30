import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserSettings: ObservableObject {
    
    @Published var step: Int = 0
    @Published var showWelcome: Bool = true
    @Published var clientID: String = ""
    private var user: User? = nil
    private var db = Firestore.firestore()
    
    init() {
        if let id = UserDefaults.standard.string(forKey: "clientID") {
            DispatchQueue.main.async {
                self.userExists(user: id, { result in
                    switch result {
                    case .success(let user):
                        self.user = user
                        self.showWelcome = false
                    case .failure(_):
                        print("not found")
                    }
                })
            }
        }
    }
    
    func setUser(user: User, clientID: String) {
        self.user = user
        UserDefaults.standard.set(clientID, forKey: "clientID")
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func userExists(user: String, _ completion: @escaping (Result<User, SignInError>) -> Void) {
        db.collection("customers").document(user).getDocument { doc, error in
            guard let user = try! doc?.data(as: User.self) else {
                completion(.failure(.UserNotFound))
                return
            }
            completion(.success(user))
        }
    }
}

enum SignInError: Error {
    case UserNotFound
}
