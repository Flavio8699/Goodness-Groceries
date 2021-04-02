import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    private var NetworkManager = GoodnessGroceries.NetworkManager()
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        ZStack {
            if UserSettings.showWelcome {
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
                        .padding(.bottom)
                    }
                } else if UserSettings.step == 5 {
                     Welcome_page6().transition(.viewTransition)
                } else if UserSettings.step == 6 {
                     Welcome_page7().transition(.viewTransition)
                }
                
                if UserSettings.statusRequested {
                    StatusRequestedView()
                }
            } else {
                GeometryReader { geometry in
                    ZStack(alignment: .bottomLeading) {
                        TabView {
                            Accueil().tabItem {
                                Image(systemName: "house.fill").font(.system(size: 23))
                                Text(NSLocalizedString("HOME", lang: UserSettings.language)).font(.system(size: 23))
                            }.tag(0)
                            Scanner().tabItem {
                                Image(systemName: "qrcode.viewfinder").font(.system(size: 23))
                                Text(NSLocalizedString("SCANNER", lang: UserSettings.language)).font(.system(size: 23))
                            }.tag(1)
                            Profile().tabItem {
                                Image(systemName: "person.circle.fill").font(.system(size: 23))
                                Text(NSLocalizedString("PROFILE", lang: UserSettings.language)).font(.system(size: 23))
                            }.tag(2)
                            Help().tabItem {
                                Image(systemName: "info.circle.fill").font(.system(size: 23))
                                Text(NSLocalizedString("HELP", lang: UserSettings.language)).font(.system(size: 23))
                            }.tag(3)
                        }.accentColor(Color("GG_D_Blue"))
                        
                        ZStack {
                          Circle()
                            .foregroundColor(.red)
                          
                          Text("\(UserSettings.productsToReview.count)")
                            .foregroundColor(.white)
                            .font(Font.system(size: 12))
                        }
                        .frame(width: 20, height: 20)
                        .offset(x: ( ( 2 * 3) - 1 ) * ( geometry.size.width / ( 2 * 4 ) ), y: -30)
                        .opacity(UserSettings.productsToReview.count == 0 ? 0 : 1)
                    }
                }
            }
            
            if UserSettings.showSurvey {
                NavigationView {
                    SurveyView()
                        .navigationBarTitle("Retour client", displayMode: .inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(NSLocalizedString("CANCEL", lang: UserSettings.language)) {
                                withAnimation(.default) {
                                    UserSettings.showSurvey = false
                                }
                            }
                        }
                    }
                }
            }
            
            if UserSettings.loading {
                ZStack {
                    Color.white
                    ProgressView()
                }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
            }
            
            if PopupManager.showPopup {
                Color.black.opacity(0.35).ignoresSafeArea().onTapGesture {
                    PopupManager.showPopup = false
                }
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Survey"), object: nil, queue: .main) { _ in
                withAnimation(.default) {
                    UserSettings.showSurvey = true
                }
            }
        }
        .popup(isPresented: $PopupManager.showPopup) {
            switch PopupManager.currentPopup {
                case .message(let title, let text):
                    MessagePopup(title: title, text: text)
                case .indicator(let indicator):
                    IndicatorPopup(indicator: indicator)
                case .error(let error):
                    switch error {
                        case .network:
                            NetworkErrorPopup()
                        case .general:
                            Text("GENERAL")
                    }
                default:
                    Text("error")
            }
        }
    }
}
