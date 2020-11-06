import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @State var showSurvey = false
    @State var surveyProducts = [String]()
    private var NetworkManager = BSP3.NetworkManager()
    
    
    var body: some View {
        ZStack {
            if UserSettings.loading {
                ProgressView()
            } else {
                if !UserSettings.showWelcome {
                    TabView {
                        Accueil().tabItem {
                            Image(systemName: "house.fill").font(.system(size: 23))
                            Text("Accueil").font(.system(size: 23))
                        }
                        Scanner().tabItem {
                            Image(systemName: "qrcode.viewfinder").font(.system(size: 23))
                            Text("Scanner").font(.system(size: 23))
                        }
                        Profile(/*user: user*/).tabItem {
                            Image(systemName: "person.circle.fill").font(.system(size: 23))
                            Text("Profil").font(.system(size: 23))
                        }
                    }
                } else {
                    if UserSettings.getStep() == 0 {
                        Welcome_page1().transition(.viewTransition)
                    } else if UserSettings.getStep() == 1 {
                        Welcome_page2().transition(.viewTransition)
                    } else if UserSettings.getStep() == 2 {
                        Welcome_page3().transition(.viewTransition)
                    } else if UserSettings.getStep() == 3 {
                        Welcome_page4().transition(.viewTransition)
                    } else if UserSettings.getStep() == 4 {
                        Welcome_page5().transition(.viewTransition)
                    }
                }
                
                if showSurvey {
                    NavigationView {
                        SurveyView(products: surveyProducts)
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                    }
                }
                
                if UserSettings.statusRequested {
                    StatusRequestedView()
                }
                
                if UserSettings.networkError {
                    BlueButton(label: "test", action: {
                        UserSettings.signIn()
                    })
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width-100, height: 120)
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.6).ignoresSafeArea())
                }
            }
        }.onAppear {
            let group = DispatchGroup()
            
            if isKeyPresentInUserDefaults(key: "completedWelcome") {
                UserSettings.signIn()
            } else {
                UserSettings.loading = false
            }
            
            DispatchQueue(label: "queue2").async(group: group) {
                // set timer to execute this code at a precise time (fetch products, 9pm?)
                NetworkManager.fetchProductsBought {
                    if let products = $0 {
                        var productsForSurvey = [String]()
                        for product in products {
                            // check if products exists and compare to current user
                            productsForSurvey.append(product.product_code)
                        }
                        //NotificationsManager().sendNotification(products: productsForSurvey)
                    }
                }
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Survey"), object: nil, queue: .main) { notif in
                if let products = notif.userInfo!["products"] {
                    for code in products as! [String] {
                        self.surveyProducts.append(code)
                        showSurvey = true
                    }
                }
            }
            
            group.wait()
        }
    }
    
    /*func handleWelcomeView() -> some View {
        /*switch UserSettings.getStep() {
        case 0: return AnyView(Welcome_page1())
            case 1: return AnyView(Welcome_page2())
            case 2: return AnyView(Welcome_page3())
            case 3: return AnyView(Welcome_page4())
            case 4: return AnyView(Welcome_page4())
            default: return AnyView(Text("error"))
        }*/
        if UserSettings.getStep() == 0 {
            return Welcome_page1()
        }
        
    }*/
}


