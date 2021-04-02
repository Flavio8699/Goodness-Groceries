import SwiftUI

struct WelcomeCategoryCell: View {
    
    let category: Category
    @State var color: Color = Color.white
    
    var body: some View {
        Button(action: {
            withAnimation(.default) {
                color = (color == Color.white) ? Color(category.color) : Color.white
            }
            
            if WelcomeViewModel.selectedIndicatorCategories.contains(category.name) {
                WelcomeViewModel.selectedIndicatorCategories.removeAll { $0 == category.name }
            } else {
                WelcomeViewModel.selectedIndicatorCategories.append(category.name)
            }
            
        }, label: {
            ZStack {
                color.cornerRadius(7)
                HStack {
                    Image(category.icon_name)
                    Text(category.description).padding(.leading, 8).fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 0)
                }.padding()
            }
        }).foregroundColor(.black)
    }
}
