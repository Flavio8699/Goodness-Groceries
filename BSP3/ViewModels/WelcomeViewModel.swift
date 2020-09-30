import Foundation

class WelcomeViewModel: ObservableObject {
    private var settings: UserSettings = UserSettings()
    
    func signIn(user: String, _ completion: @escaping (Result<User, SignInError>) -> Void) {
        self.settings.userExists(user: user, { result in
            completion(result)
        })
    }
    
}
