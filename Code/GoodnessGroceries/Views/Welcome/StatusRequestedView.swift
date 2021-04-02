import SwiftUI

struct StatusRequestedView: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings
    private var NetworkManager = GoodnessGroceries.NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 30) {
                Text(NSLocalizedString("AUTHENTICATION_REQUESTED", lang: UserSettings.language))
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.circle").foregroundColor(Color("GG_D_Green")).font(.system(size: 100))
                    Spacer()
                }
                BlueButton(label: NSLocalizedString("OPEN_FORM", lang: UserSettings.language), action: {
                    openURL(URL(string: "https://www.apple.com")!)
                }).padding(.top, 20)
                Spacer()
            }.padding()
            .navigationBarTitle(NSLocalizedString("LAST_STEP", lang: UserSettings.language))
        }
    }
}
