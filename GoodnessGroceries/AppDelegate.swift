//
//  AppDelegate.swift
//  BSP3
//
//  Created by Flavio Matias on 16/09/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    let popupManager = PopupManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            UNUserNotificationCenter.current().delegate = self
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
            return true
        }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        
        DispatchQueue.main.async {
            if content.userInfo["products"] != nil {
                if let products = content.userInfo["products"] as? [String] {
                    if products.count > 0 {
                        UserSettings.shared.productsToReview.removeAll()
                        for product in products {
                            UserSettings.shared.productsToReview.append(product)
                        }
                    }
                }
            }
        }
 
        completionHandler([.banner, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        guard response.actionIdentifier == UNNotificationDefaultActionIdentifier else { return }
        
        let content = response.notification.request.content
        DispatchQueue.main.async {
            if content.userInfo["products"] != nil {
                if let products = content.userInfo["products"] as? [String] {
                    if products.count > 0 {
                        UserSettings.shared.productsToReview.removeAll()
                        for product in products {
                            UserSettings.shared.productsToReview.append(product)
                        }
                    }
                }

                NotificationCenter.default.post(name: NSNotification.Name("Products"), object: nil, userInfo: content.userInfo)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("Other"), object: nil, userInfo: content.userInfo)
            }
        }
        
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        UserSettings.shared.deviceToken = token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error remote notifications \(error.localizedDescription)")
    }

}

func appDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}
