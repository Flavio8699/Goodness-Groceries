import SwiftUI

struct Help: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings

    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 0) {
                VStack {
                    Image("GG-Logo-1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                    Text(NSLocalizedString("WELCOME_PAGE_1_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                }.padding()
                Divider()
                Form {
                    Section(header: Text(NSLocalizedString("HELP", lang: UserSettings.language))) {
                        NavigationLink(destination: IndicatorsHelpView()) {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_1", lang: UserSettings.language))
                        }
                        Button(action: {
                            openURL(URL(string: "http://food.daloos.uni.lu/projects/research-projects/sustainable-shopping-app/help-page/")!)
                        }, label: {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_2", lang: UserSettings.language)).foregroundColor(.black)
                        })
                        Button(action: {
                            openURL(URL(string: "http://food.daloos.uni.lu/projects/research-projects/sustainable-shopping-app/contact-us/")!)
                        }, label: {
                            Text(NSLocalizedString("HELP_PAGE_BUTTON_3", lang: UserSettings.language)).foregroundColor(.black)
                        })
                    }
                }
            }
            .navigationBarTitle(NSLocalizedString("HELP", lang: UserSettings.language))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
