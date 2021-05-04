import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @State var languages = ["fr", "en"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack (alignment: .top, spacing: 25) {
                    Image(systemName: "person.crop.circle").font(.system(size: 100))
                    VStack (alignment: .leading, spacing: 10) {
                        Text(NSLocalizedString("CLIENT_ID", lang: UserSettings.language)).font(.title)
                        Text(UserSettings.clientID)
                    }.offset(y: 15)
                    Spacer()
                }.padding()
                Divider()
                Form {
                    Section(header: Text(NSLocalizedString("PRODUCTS", lang: UserSettings.language))) {
                        Button(action: {
                            if !Connectivity.connected {
                                PopupManager.currentPopup = .error(.network)
                            } else {
                                withAnimation(.default) {
                                    UserSettings.showSurvey = true
                                }
                            }
                        }, label: {
                            HStack {
                                Text("Review products TT")
                                Spacer()
                                ZStack {
                                  Circle()
                                    .foregroundColor(.red)
                                  
                                  Text("\(UserSettings.productsToReview.count)")
                                    .foregroundColor(.white)
                                    .font(Font.system(size: 15))
                                }
                                .frame(width: 25, height: 25)
                                .opacity(UserSettings.productsToReview.count == 0 ? 0 : 1)
                            }
                        }).disabled(UserSettings.productsToReview.count == 0 ? true : false)
                        .foregroundColor(UserSettings.productsToReview.count == 0 ? Color(.systemGray) : Color.black)
                    }
                    
                    Section(header: Text(NSLocalizedString("SETTINGS", lang: UserSettings.language))) {
                        Picker(NSLocalizedString("LANGUAGE", lang: UserSettings.language), selection: $UserSettings.language) {
                            ForEach(languages, id: \.self) {
                                Text(NSLocalizedString($0, lang: UserSettings.language))
                            }
                        }
                        Button(action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }, label: {
                            Text(NSLocalizedString("NOTIFICATIONS", lang: UserSettings.language)).foregroundColor(.black)
                        })
                    }
                }
            }
            .navigationBarTitle(NSLocalizedString("PROFILE", lang: UserSettings.language))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
