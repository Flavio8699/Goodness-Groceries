import SwiftUI

struct CameraNotAllowedView: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack (spacing: 15) {
            Spacer()
            Image("GG-Logo-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .padding(.bottom, 50)
            Text(NSLocalizedString("CAMERA_NOT_ALLOWED", lang: UserSettings.language))
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }, label: {
                Text(NSLocalizedString("OPEN_SETTINGS", lang: UserSettings.language))
            })
            Spacer()
        }.padding(.horizontal, 25)
    }
}
