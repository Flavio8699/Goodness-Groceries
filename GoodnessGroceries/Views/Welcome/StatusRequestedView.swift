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
            }.padding(.bottom, 15)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TITLE", lang: UserSettings.language)).font(.title)
                VStack (alignment: .leading, spacing: 15) {
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TEXT_1", lang: UserSettings.language))
                    Text(NSLocalizedString("AUTHENTICATION_REQUESTED_TEXT_2", lang: UserSettings.language))
                }
                BlueButton(label: NSLocalizedString("OPEN_FORM", lang: UserSettings.language), action: {
                    openURL(URL(string: "https://food.uni.lu/projects/goodness-groceries/")!)
                }).padding(.top, 20)
                Spacer(minLength: 0)
                HStack (spacing: 10) {
                    Spacer(minLength: 0)
                    Image("uni_logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                    Image("pall_center")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 120)
                    Spacer(minLength: 0)
                }
            }
        }.padding()
    }
}
