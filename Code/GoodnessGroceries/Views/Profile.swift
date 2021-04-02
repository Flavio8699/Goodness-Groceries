import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    private var languages = ["fr", "en"]
    private var languageNames = ["fr": "Français", "en": "English"]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                HStack (alignment: .top, spacing: 25) {
                    Image(systemName: "person.crop.circle").font(.system(size: 100))
                    VStack (alignment: .leading, spacing: 10) {
                        Text(NSLocalizedString("CLIENT_ID", lang: UserSettings.language)).font(.title)
                        Text(UserSettings.clientID)
                    }.offset(y: 15)
                    Spacer()
                }
                Section(header: Text(NSLocalizedString("LANGUAGE", lang: UserSettings.language))) {
                    Picker("Names", selection: $UserSettings.language) {
                        ForEach(languages, id: \.self) { lang in
                            Text(languageNames[lang]!)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
            .navigationBarTitle(NSLocalizedString("PROFILE", lang: UserSettings.language))
        }
    }
}

