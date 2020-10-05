import SwiftUI

struct Profile: View {
    
    let notifs = NotificationsManager()
    let user: User
    
    var body: some View {
        BlueButton(label: "Send notification test") {
            self.notifs.sendNotification()
        }
    }
}

