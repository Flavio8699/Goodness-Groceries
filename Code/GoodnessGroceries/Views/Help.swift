import SwiftUI

struct Help: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        ScrollView {
            ForEach(productsVM.indicators, id: \.self) { ind in
                HStack {
                    Image(ind.icon_name)
                VStack (alignment: .leading, spacing: 12) {
                    Text(NSLocalizedString(ind.name, lang: UserSettings.language)).font(.title3)
                    Text(NSLocalizedString(ind.general_description, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                }
                }
                Divider()
            }
        }.padding()
    }
}
