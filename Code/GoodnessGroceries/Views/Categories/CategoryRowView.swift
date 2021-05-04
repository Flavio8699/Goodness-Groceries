import SwiftUI

struct CategoryRowView: View {
    
    let category: Category
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        NavigationLink(destination: ProductCategoryListView(category: category)) {
            VStack (alignment: .leading) {
                HStack {
                    Image(category.icon_name).frame(width: 60)
                    Text(NSLocalizedString(category.name, lang: UserSettings.language)).font(.system(size: 20))
                    Spacer(minLength: 0)
                    Image("arrow_right").padding(.top, 4).frame(width: 20)
                }
                HStack {
                    Text(NSLocalizedString(category.description, lang: UserSettings.language)).font(.system(size: 14)).fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 20)
                }
            }
        }
        .padding(.vertical, 10)
        .navigationBarTitle(NSLocalizedString("HOME", lang: UserSettings.language))
    }
}
