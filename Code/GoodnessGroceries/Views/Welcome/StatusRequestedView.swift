import SwiftUI
import PermissionsSwiftUI

struct StatusRequestedView: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            HStack (spacing: 25) {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                Image("uni_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 40)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TITLE", lang: UserSettings.language)).font(.title)
                VStack (alignment: .leading, spacing: 15) {
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TEXT_1", lang: UserSettings.language))
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TEXT_2", lang: UserSettings.language))
                }
                BlueButton(label: NSLocalizedString("OPEN_FORM", lang: UserSettings.language), action: {
                    openURL(URL(string: "https://www.apple.com")!)
                }).padding(.top, 20)
                Spacer(minLength: 0)
            }
        }.padding()
    }
}
