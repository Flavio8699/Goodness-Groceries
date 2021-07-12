//
//  NotificationService.swift
//  push-notifications
//
//  Created by Flavio Matias on 04/05/2021.
//  Copyright © 2021 Flavio Matias. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            var language: String = "en"
            if let userDefaults = UserDefaults(suiteName: "group.lu.uni.bicslab.goodnessgroceries") {
                language = userDefaults.string(forKey: "language") ?? "en"
            }
            
            bestAttemptContent.title = NSLocalizedString(bestAttemptContent.title, lang: language)
            bestAttemptContent.body = NSLocalizedString(bestAttemptContent.body, lang: language)
            
            contentHandler(bestAttemptContent)
        } else {
            contentHandler(request.content)
        }
    }
    
    override func serviceExtensionTimeWillExpire() { }

}
