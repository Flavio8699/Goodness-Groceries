import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @State var showSurvey = false
    @State var surveyProducts = [String]()
    
    var body: some View {
        ZStack {
            VStack {
                if !UserSettings.showWelcome && UserSettings.getUser() != nil {
                    let user = UserSettings.getUser()!
                    TabView {
                        Accueil().tabItem {
                            Image(systemName: "house.fill").font(.system(size: 23))
                            Text("Accueil").font(.system(size: 23))
                        }
                        Scanner().tabItem {
                            Image(systemName: "qrcode.viewfinder").font(.system(size: 23))
                            Text("Scanner").font(.system(size: 23))
                        }
                        Profile(user: user).tabItem {
                            Image(systemName: "person.circle.fill").font(.system(size: 23))
                            Text("Profil").font(.system(size: 23))
                        }
                    }
                } else {
                    handleWelcomeView()
                }
            }
            if showSurvey {
                NavigationView {
                    SurveyView(products: surveyProducts)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                }
            }
        }.onAppear {
            NetworkManager().fetchProductsBought {
                if let products = $0 {
                    var productsForSurvey = [String]()
                    for product in products {
                        // check if products exists and compare to current user
                        productsForSurvey.append(product.product_id)
                    }
                    NotificationsManager().sendNotification(products: productsForSurvey)
                }
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Survey"), object: nil, queue: .main) { xx in
                if let productIDs = xx.userInfo!["products"] {
                    for i in productIDs as! [String] {
                        self.surveyProducts.append(i)
                    }
                }
                showSurvey = true
            }
        }
    }
    
    func handleWelcomeView() -> AnyView {
        switch UserSettings.getStep() {
            case 0: return AnyView(Welcome_page1())
            case 1: return AnyView(Welcome_page2())
            case 2: return AnyView(Welcome_page3())
            case 3: return AnyView(Welcome_page4())
            case 4: return AnyView(Welcome_page4())
            default: return AnyView(Text("error"))
        }
    }
}


