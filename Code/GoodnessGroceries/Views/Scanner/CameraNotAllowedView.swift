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
            Text("Goodness Groceries was not granted access to your camera in order to scan QR-codes. Please change that in your settings. Thank you.")
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }, label: {
                Text("Open settings")
            })
            Spacer()
        }.padding(.horizontal, 25)
    }
}
