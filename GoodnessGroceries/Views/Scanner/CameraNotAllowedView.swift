import SwiftUI

struct CameraNotAllowedView: View {
    
    var body: some View {
        VStack (spacing: 15) {
            Spacer()
            Image("GG-Logo-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .padding(.bottom, 50)
            Text(NSLocalizedString("CAMERA_NOT_ALLOWED", lang: UserSettings.shared.language))
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }, label: {
                Text(NSLocalizedString("OPEN_SETTINGS", lang: UserSettings.shared.language))
            })
            Spacer()
        }.padding(.horizontal, 25)
    }
}
