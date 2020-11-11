import SwiftUI

struct WelcomeProductCategoryCell: View {
    
    let category: ProductCategoryWelcome
    @State var color: Color = Color.white
    
    var body: some View {
        Button(action: {
            withAnimation(.default) {
                color = (color == Color.white) ? category.color : Color.white
            }
        }, label: {
            ZStack (alignment: .top) {
                color.cornerRadius(7)
                Image(category.icon).resizable().frame(width: 80, height: 80).offset(y: 60)
                Text(category.name).lineLimit(3).multilineTextAlignment(.center).padding(.horizontal, 8).padding(.vertical, 8)
            }
        }).foregroundColor(.black)
    }
}
