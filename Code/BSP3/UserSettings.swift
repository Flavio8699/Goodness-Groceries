import Foundation

class UserSettings: ObservableObject {
    
    @Published private var step: Int = 0
    @Published var clientID: String = ""
    @Published var statusRequested: Bool = false
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
            self.step = self.getStep()
        }
        
        self.handleShowWelcome()
    }
    
    func signIn() {
        self.NetworkManager.fetchUserStatus {
            switch $0 {
            case let .success(status):
                switch status.status {
                case .requested:
                    self.statusRequested = true
                case .valid:
                    self.statusRequested = false
                    UserDefaults.standard.removeObject(forKey: "statusRequested")
                }
                self.handleShowWelcome()
                self.networkError = false
            case .failure(_):
                self.networkError = true
            }
            self.loading = false
        }
    }
    
    func handleShowWelcome() {
        if self.getStep() == 7 { // # of welcome pages
            self.showWelcome = false
        } else {
            self.showWelcome = true
        }
    }
    
    func getStep() -> Int {
        return UserDefaults.standard.integer(forKey: "step")
    }
    
    func nextStep() {
        self.step += 1
        UserDefaults.standard.set(self.getStep()+1, forKey: "step")
        self.handleShowWelcome()
    }
    
    func requestAccess() {
        self.statusRequested = true
        UserDefaults.standard.set(true, forKey: "statusRequested")
        UserDefaults.standard.set(clientID, forKey: "clientID")
        NetworkManager.requestUserAccess(for: clientID)
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
