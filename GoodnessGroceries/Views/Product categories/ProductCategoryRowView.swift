import SwiftUI

struct ProductCategoryRowView: View {
    
    let product_category: ProductCategory
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 15) {
                Image("GG-\(product_category.rawValue)").frame(width: 60)
                Text(NSLocalizedString(product_category.description, lang: UserSettings.language)).font(.headline)
                Spacer(minLength: 0)
                Image("arrow_right").padding(.top, 4)
            }
        }
        .padding(.vertical, 5)
        .navigationBarTitle(NSLocalizedString("PRODUCT_CATEGORIES", lang: UserSettings.language))
    }
}
