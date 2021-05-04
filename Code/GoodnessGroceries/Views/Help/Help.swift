import SwiftUI

struct Help: View {
    
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
                            Text("Indicator definitions TT")
                        }
                        Button(action: {
                            
                        }, label: {
                            Text("button 2").foregroundColor(.black)
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("button 3").foregroundColor(.black)
                        })
                    }
                }
            }
            .navigationBarTitle(NSLocalizedString("HELP", lang: UserSettings.language))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
