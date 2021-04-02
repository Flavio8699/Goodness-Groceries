import SwiftUI

struct WelcomeProductCategoryCell: View {
    
    let category: ProductCategoryWelcome
    @State var color: Color = Color.white
    @StateObject var welcomeVM = WelcomeViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        Button(action: {
            withAnimation(.default) {
                color = (color == Color.white) ? category.color : Color.white
            }
            
            if WelcomeViewModel.selectedProductCategories.contains(category.name) {
                WelcomeViewModel.selectedProductCategories.removeAll { $0 == category.name }
            } else {
                WelcomeViewModel.selectedProductCategories.append(category.name)
            }
            
        }, label: {
            ZStack {
                color.cornerRadius(7)
                HStack {
                    Image(category.icon)
                    Text(NSLocalizedString(category.name, lang: UserSettings.language)).padding(.leading, 8).fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }.padding()
            }
        }).foregroundColor(.black)
    }
}
