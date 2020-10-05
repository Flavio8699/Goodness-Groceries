import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserSettings: ObservableObject {
    
    @Published private var step: Int = 0
    @Published var clientID: String = ""
    @Published var showWelcome: Bool = true
    private var user: User? = nil
    private var db = Firestore.firestore()
    
    init() {
        if let id = UserDefaults.standard.string(forKey: "clientID") {
            DispatchQueue.main.async {
                self.clientID = id
                self.userExists { result in
                    switch result {
                    case .success(let user):
                        self.user = user
                        self.showWelcome = user.showWelcome
                    case .failure(_):
                        print("not found")
                    }
                }
            }
        }
    }
    
    func setUser(user: User) {
        self.user = user
        UserDefaults.standard.set(clientID, forKey: "clientID")
    }
    
    func getUser() -> User? {
        return self.user
    }
    
    func signIn(_ completion: @escaping (Result<User, SignInError>) -> Void) {
        self.userExists { result in
            completion(result)
        }
    }
    
    func userExists(_ completion: @escaping (Result<User, SignInError>) -> Void) {
        db.collection("customers").document(clientID).getDocument { doc, error in
            guard let user = try! doc?.data(as: User.self) else {
                completion(.failure(.UserNotFound))
                return
            }
            completion(.success(user))
        }
    }
    
    func getStep() -> Int {
        return self.step
    }
    
    func nextStep() {
        self.step += 1
    }
    
    func updateWelcome() {
        db.collection("customers").document(clientID).updateData(["showWelcome": false]) { error in
            if let error = error {
                print(error)
            } else {
                self.showWelcome = false
            }
        }
    }
}

enum SignInError: Error {
    case UserNotFound
}
