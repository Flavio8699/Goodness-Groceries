import Foundation

class UserSettings: ObservableObject {
    
    @Published var step: Int = 0 {
        didSet {
            UserDefaults.standard.set(step, forKey: "step")
            self.handleShowWelcome()
        }
    }
    @Published var clientID: String = "" {
        didSet {
            UserDefaults.standard.set(clientID, forKey: "clientID")
        }
    }
    @Published var statusRequested: Bool = false {
        didSet {
            UserDefaults.standard.set(statusRequested, forKey: "statusRequested")
        }
    }
    @Published var productsToReview = [String]() {
        didSet {
            UserDefaults.standard.set(productsToReview, forKey: "productsToReview")
        }
    }
    @Published var language: String = "en" {
        didSet {
            UserDefaults.standard.set(language, forKey: "language")
        }
    }
    @Published var showSurvey: Bool = false
    @Published var showWelcome: Bool = true
    @Published var loading: Bool = false
    private var NetworkManager = GoodnessGroceries.NetworkManager()
    
    init() {
        if !isKeyPresentInUserDefaults(key: "step") {
            UserDefaults.standard.set(0, forKey: "step")
        } else {
            self.step = UserDefaults.standard.integer(forKey: "step")
        }
        
        if isKeyPresentInUserDefaults(key: "clientID") {
            self.clientID = UserDefaults.standard.string(forKey: "clientID")!
        }
        
        if isKeyPresentInUserDefaults(key: "statusRequested") {
            self.statusRequested = true
        }
        
        if isKeyPresentInUserDefaults(key: "productsToReview") {
            self.productsToReview = UserDefaults.standard.stringArray(forKey: "productsToReview")!
        }
        
        if isKeyPresentInUserDefaults(key: "language") {
            self.language = UserDefaults.standard.string(forKey: "language")!
        }
        
        self.handleShowWelcome()
    }
    
    func signIn() {
        self.loading = true
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
                break
            case .failure(let type):
                appDelegate().popupManager.currentPopup = .error(type)
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
