import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                HStack (alignment: .top, spacing: 25) {
                    Image(systemName: "person.crop.circle").font(.system(size: 100))
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Identifiant").font(.title)
                        Text(UserSettings.clientID)
                    }.offset(y: 15)
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            .navigationBarTitle("Profil")
        }
    }
}

