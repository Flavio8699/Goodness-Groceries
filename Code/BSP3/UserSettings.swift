import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserSettings: ObservableObject {
    
    @Published private var step: Int = 0
    @Published var clientID: String = ""
    @Published var statusRequested: Bool = false
    @Published var showWelcome: Bool = true
    private var NetworkManager = BSP3.NetworkManager()
    private var user: User? = nil
    private var db = Firestore.firestore()
    
    init() {
        /*if let id = UserDefaults.standard.string(forKey: "clientID") {
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
        }*/
    }
    
    func signIn() {
        NetworkManager.fetchUserStatus {
            guard let userStatus = $0 else {
                return
            }
            switch userStatus.status {
            case .requested:
                print("requested")
                self.statusRequested = true
                // tests
                //self.showWelcome = false
            case .valid:
                print("valid")
                self.statusRequested = false
                self.showWelcome = false
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
    
    /*func signIn(_ completion: @escaping (Result<User, SignInError>) -> Void) {
        self.userExists { result in
            completion(result)
        }
    }*/
    
    func userExists(_ completion: @escaping (Result<User, ResultError>) -> Void) {
        /*db.collection("customers").document(clientID).getDocument { doc, error in
            guard let user = try! doc?.data(as: User.self) else {
                completion(.failure(.UserNotFound))
                return
            }
            completion(.success(user))
        }*/
    }
    
    func getStep() -> Int {
        return self.step
    }
    
    func nextStep() {
        self.step += 1
    }
    
    func requestAccess() {
        self.statusRequested = true
        // NetworkManager post for access request
    }
}

enum ResultError: Error {
    case Error
    case UserNotFound
    case NetworkError
}
