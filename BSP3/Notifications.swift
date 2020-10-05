import Foundation
import UserNotifications

class NotificationsManager {
    
    func sendNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (status,_) in
            if status {
                let content = UNMutableNotificationContent()
                content.title = "Retour client"
                content.body = "Répondez à notre enquête rapide et obtenez des récompenses"
                content.sound = UNNotificationSound.default
                content.badge = NSNumber(value: 1)
                content.userInfo = ["products": [1,4,7]]
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false))
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                return
            }
        }
    }
}
