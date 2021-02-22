import Foundation

class UserSettings: ObservableObject {
    
    @Published var step: Int = 0 {
        didSet {
            UserDefaults.standard.set(step, forKey: "step")
            self.handleShowWelcome()
        }
    }
    @Published var clientID: String = ""
    @Published var statusRequested: Bool = false {
        didSet {
            UserDefaults.standard.set(statusRequested, forKey: "statusRequested")
            if !clientID.isEmpty {
                UserDefaults.standard.set(clientID, forKey: "clientID")
            }
        }
    }
    @Published var showWelcome: Bool = true
    @Published var networkError: Bool = false
    @Published var loading: Bool = true
    private var NetworkManager = BSP3.NetworkManager()
    
    init() {
        if isKeyPresentInUserDefaults(key: "statusRequested") {
            self.statusRequested = true
        }
        
        if isKeyPresentInUserDefaults(key: "clientID") {
            self.clientID = UserDefaults.standard.string(forKey: "clientID")!
        }
        
        if !isKeyPresentInUserDefaults(key: "step") {
            UserDefaults.standard.set(0, forKey: "step")
        } else {
            self.step = UserDefaults.standard.integer(forKey: "step")
        }
        
        self.handleShowWelcome()
    }
    
    func signIn() {
        self.NetworkManager.fetchUserStatus(for: clientID) { response in
            switch response {
            case .success(let status):
                switch status {
                case .requested:
                    self.statusRequested = true
                    break
                case .valid:
                    self.statusRequested = false
                    UserDefaults.standard.removeObject(forKey: "statusRequested")
                    break
                }
                self.handleShowWelcome()
                self.networkError = false
                break
            case .failure(_):
                self.networkError = true
                break
            }
            self.loading = false
        }
    }
    
    func handleShowWelcome() {
        if step == 7 { // # of welcome pages
            self.showWelcome = false
        } else {
            self.showWelcome = true
        }
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
