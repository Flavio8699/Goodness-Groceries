import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @State var showSurvey = false
    var surveyProducts: [Int] = [0]
    
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
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Survey"), object: nil, queue: .main) { xx in
                if let productIDs = xx.userInfo!["products"] {
                    for i in productIDs as! [Int] {
                        //self.surveyProducts.append(i)
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


