//
//  SceneDelegate.swift
//  BSP3
//
//  Created by Flavio Matias on 16/09/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Get the managed object context from the shared persistent container.
        let context = appDelegate.persistentContainer.viewContext
        
        if !isKeyPresentInUserDefaults(key: "language") {
            if getPreferredLocale().languageCode == "fr" {
                appDelegate.UserSettings.language = "fr"
            } else {
                appDelegate.UserSettings.language = "en"
            }
        }
        
        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = ContentView().environment(\.managedObjectContext, context).environmentObject(appDelegate.UserSettings).environmentObject(appDelegate.popupManager)
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.

        if isKeyPresentInUserDefaults(key: "statusRequested") {
            appDelegate.UserSettings.signIn()
        }
        
        if !appDelegate.UserSettings.showWelcome {
            DispatchQueue(label: "queue").async() {
                NetworkManager().fetchProductsBought(for: self.appDelegate.UserSettings.clientID) { result in
                    switch result {
                        case .success(let products):
                            if let products = products {
                                self.appDelegate.UserSettings.productsToReview.removeAll()
                                for product in products {
                                    let code = String(product.product)
                                    self.appDelegate.UserSettings.productsToReview.append(code)
                                }
                                
                                if self.appDelegate.UserSettings.productsToReview.count > 0 {
                                    NotificationsManager().sendNotification()
                                }
                            }
                            break
                            
                        case .failure(_):
                            print("Error while fetching products bought")
                            break
                    }
                }
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("deep link opened")
        print("\(URLContexts.first!.url)")
        appDelegate.UserSettings.loading = true
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        appDelegate.saveContext()
        UIApplication.shared.applicationIconBadgeNumber = appDelegate.UserSettings.productsToReview.count
    }


}
