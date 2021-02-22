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
                    if UserSettings.step >= 0 && UserSettings.step <= 4 {
                        VStack {
                            ZStack(alignment: .bottom) {
                                Welcome()
                            }
                            Spacer()
                            HStack(spacing: 8) {
                                ForEach(0..<5) { index in
                                    Bullet(isSelected: UserSettings.step == index, action: {
                                        withAnimation {
                                            UserSettings.step = index
                                        }
                                    })
                                }
                            }
                            .padding(.bottom, 12)
                        }
                    } else {
                        if UserSettings.step == 5 {
                            Welcome_page6().transition(.viewTransition)
                        } else {
                            Welcome_page7().transition(.viewTransition)
                        }
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
            
            NetworkManager.checkInternet { av in
                print("available:", av)
            }
            
            /*DispatchQueue(label: "queue2").async(group: group) {
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
            }*/
            
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
}

