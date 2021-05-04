import Foundation

class UserSettings: ObservableObject {
    static let shared = UserSettings()
    let userDefaults = UserDefaults(suiteName: "group.lu.uni.bicslab.goodnessgroceries")
    
    @Published var step: Int = 0 {
        didSet {
            if let userDefaults = userDefaults {
                userDefaults.set(step, forKey: "step")
                userDefaults.synchronize()
            }
            self.handleShowWelcome()
        }
    }
    @Published var clientID: String = "" {
        didSet {
            if let userDefaults = userDefaults {
                userDefaults.set(clientID, forKey: "clientID")
                userDefaults.synchronize()
            }
        }
    }
    @Published var statusRequested: Bool = false {
        didSet {
            if let userDefaults = userDefaults {
                userDefaults.set(statusRequested, forKey: "statusRequested")
                userDefaults.synchronize()
            }
        }
    }
    @Published var productsToReview = [String]() {
        didSet {
            if let userDefaults = userDefaults {
                userDefaults.set(productsToReview, forKey: "productsToReview")
                userDefaults.synchronize()
            }
        }
    }
    @Published var language: String = "en" {
        didSet {
            if let userDefaults = userDefaults {
                userDefaults.set(language, forKey: "language")
                userDefaults.synchronize()
            }
        }
    }
    @Published var deviceToken: String = ""
    @Published var showSurvey: Bool = false
    @Published var showWelcome: Bool = true
    @Published var loading: Bool = false
    
    init() {
        if let userDefaults = userDefaults {
            if !isKeyPresentInUserDefaults(key: "step") {
                userDefaults.set(0, forKey: "step")
                userDefaults.synchronize()
            } else {
                self.step = userDefaults.integer(forKey: "step")
            }
            
            if isKeyPresentInUserDefaults(key: "clientID") {
                self.clientID = userDefaults.string(forKey: "clientID")!
            }
            
            if isKeyPresentInUserDefaults(key: "statusRequested") {
                self.statusRequested = true
            }
            
            if isKeyPresentInUserDefaults(key: "productsToReview") {
                self.productsToReview = userDefaults.stringArray(forKey: "productsToReview")!
            }
            
            if isKeyPresentInUserDefaults(key: "language") {
                self.language = userDefaults.string(forKey: "language")!
            }
        }
    
        self.handleShowWelcome()
    }
    
    func signIn() {
        self.loading = true
        NetworkManager.shared.fetchUserStatus(for: clientID) { response in
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
                break
            case .failure(let type):
                appDelegate().popupManager.currentPopup = .error(type)
                break
            }
            self.loading = false
        }
    }
    
    func handleShowWelcome() {
        if step == 8 { // # of welcome pages
            self.showWelcome = false
        } else {
            self.showWelcome = true
        }
    }
}

func isKeyPresentInUserDefaults(key: String) -> Bool {
    if let userDefaults = UserDefaults(suiteName: "group.lu.uni.bicslab.goodnessgroceries") {
        return userDefaults.object(forKey: key) != nil
    }
    return false
}
