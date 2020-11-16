import SwiftUI

struct StatusRequestedView: View {
    
    @Environment(\.openURL) var openURL
    @EnvironmentObject var UserSettings: UserSettings
    private var NetworkManager = BSP3.NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 30) {
                Text("Votre demande sera envoyée et traité dès que vous remplissez le formulaire dispobile sur le lien si-dessous. Merci pour votre compréhension.")
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.circle").foregroundColor(.green).font(.system(size: 100))
                    Spacer()
                }
                BlueButton(label: "Ouvrir le formulaire", action: {
                    openURL(URL(string: "https://www.apple.com")!)
                }).padding(.top, 20)
                Spacer()
            }.padding()
            .navigationBarTitle("Dernière étape")
        }
    }
}
