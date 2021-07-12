import Foundation
import UserNotifications

class NotificationsManager {
    
    func sendNotification(products: [String]) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (status,_) in
            if status {
                let content = UNMutableNotificationContent()
                content.title = "Retour client"
                content.body = "Répondez à notre enquête rapide et obtenez des récompenses"
                content.sound = UNNotificationSound.default
                let userInfo: [String: [String]] = ["products": products]
                content.userInfo = userInfo
                content.badge = products.count as NSNumber
            
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false))
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                return
            }
        }
    }
}
