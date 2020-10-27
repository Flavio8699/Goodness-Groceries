import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserSettings: ObservableObject {
    
    @Published private var step: Int = 0
    @Published var clientID: String = ""
    @Published var statusRequested: Bool = false
    @Published var showWelcome: Bool = true
    @Published var networkError: Bool = false
    @Published var loading: Bool = true
    private var NetworkManager = BSP3.NetworkManager()
    private var user: User? = nil
    private var db = Firestore.firestore()
    
    init() {
        if isKeyPresentInUserDefaults(key: "completedWelcome") {
            self.showWelcome = false
        }
        if isKeyPresentInUserDefaults(key: "statusRequested") {
            self.statusRequested = true
        }
    }
    
    func signIn() {
        self.NetworkManager.fetchUserStatus {
            switch $0 {
            case let .success(status):
                switch status.status {
                case .requested:
                    print("requested")
                    self.showWelcome = false
                    self.statusRequested = true
                case .valid:
                    print("valid")
                    self.showWelcome = false
                    self.statusRequested = false
                    UserDefaults.standard.removeObject(forKey: "statusRequested")
                }
                self.networkError = false
            case .failure(_):
                self.networkError = true
            }
            self.loading = false
        }
    }
    
    func setUser(user: User) {
        self.user = user
        UserDefaults.standard.set(clientID, forKey: "clientID")
    }
    
    func getStep() -> Int {
        return self.step
    }
    
    func nextStep() {
        self.step += 1
    }
    
    func completedWelcome() {
        UserDefaults.standard.set(true, forKey: "completedWelcome")
    }
    
    func requestAccess() {
        self.statusRequested = true
        UserDefaults.standard.set(true, forKey: "statusRequested")
        // NetworkManager post for access request
    }
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

enum ResultError: Error {
    case Error
    case UserNotFound
    case NetworkError
}
