import SwiftUI

struct CategoryRowView: View {
    
    let category: Category
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack (alignment: .leading) {
            NavigationLink(destination: ProductsListView(category: category)) {
                HStack {
                    Text(NSLocalizedString(category.name, lang: UserSettings.language)).font(.title)
                    Spacer(minLength: 0)
                    Image("arrow_right").padding(.top, 4)
                }
            }
            VStack (alignment: .leading, spacing: 12) {
                HStack (spacing: 20) {
                    Image(category.icon_name)
                    Text(NSLocalizedString(category.description, lang: UserSettings.language)).font(.system(size: 14)).fixedSize(horizontal: false, vertical: true)
                }.padding(10)
            }
        }
        .navigationBarTitle(NSLocalizedString("HOME", lang: UserSettings.language))
    }
}
