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

        if UserSettings.shared.language == "undefined" {
            if getPreferredLocale().languageCode == "fr" {
                UserSettings.shared.language = "fr"
            } else {
                UserSettings.shared.language = "en"
            }
        }
        
        let contentView = ContentView().environmentObject(UserSettings.shared).environmentObject(appDelegate.popupManager)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) {
        if UserSettings.shared.statusRequested == true {
            UserSettings.shared.signIn()
        }

        if !UserSettings.shared.showWelcome {
            DispatchQueue.main.async {
                NetworkManager.shared.fetchProductsBought(for: UserSettings.shared.clientID) { result in
                    switch result {
                        case .success(let products):
                            if let products = products {
                                UserSettings.shared.productsToReview.removeAll()
                                for product in products {
                                    let code = String(product.product)
                                    UserSettings.shared.productsToReview.append(code)
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

    func sceneDidEnterBackground(_ scene: UIScene) {
        UIApplication.shared.applicationIconBadgeNumber = UserSettings.shared.productsToReview.count
    }
}
