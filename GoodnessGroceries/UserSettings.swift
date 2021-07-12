import Foundation
import Combine

class UserSettings: ObservableObject {
    static let shared = UserSettings()
    let objectWillChange = ObservableObjectPublisher()
    let sharedUserDefaults = UserDefaults(suiteName: "group.lu.uni.bicslab.goodnessgroceries")
    
    var step: Int {
        get {
            return UserDefaults.standard.integer(forKey: "step")
        }
        set (step) {
            self.objectWillChange.send()
            UserDefaults.standard.set(step, forKey: "step")
            self.handleShowWelcome()
        }
    }
    
    var clientID: String {
        get {
            UserDefaults.standard.string(forKey: "clientID") ?? ""
        }
        set (id) {
            self.objectWillChange.send()
            UserDefaults.standard.set(id, forKey: "clientID")
        }
    }
    
    var statusRequested: Bool {
        get {
            UserDefaults.standard.bool(forKey: "statusRequested")
        }
        set (status) {
            self.objectWillChange.send()
            UserDefaults.standard.set(status, forKey: "statusRequested")
        }
    }
    
    var productsToReview: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "productsToReview") ?? []
        }
        set (products) {
            self.objectWillChange.send()
            UserDefaults.standard.set(products, forKey: "productsToReview")
        }
    }
    
    var language: String {
        get {
            if let userDefaults = sharedUserDefaults {
                return userDefaults.string(forKey: "language") ?? "undefined"
            }
            return "undefined"
        }
        set (language) {
            if let userDefaults = sharedUserDefaults {
                self.objectWillChange.send()
                userDefaults.set(language, forKey: "language")
                userDefaults.synchronize()
            }
        }
    }
    
    var deviceToken: String = "" {
        willSet { self.objectWillChange.send() }
    }
    
    var showSurvey: Bool = false {
        willSet { self.objectWillChange.send() }
    }
    
    var showWelcome: Bool = true {
        willSet { self.objectWillChange.send() }
    }
    
    var loading: Bool = false {
        willSet { self.objectWillChange.send() }
    }
    
    init() {
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
