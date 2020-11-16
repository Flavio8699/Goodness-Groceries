import SwiftUI

struct WelcomeCategoryCell: View {
    
    let category: CategoryWelcome
    @State var color: Color = Color.white
    
    var body: some View {
        Button(action: {
            withAnimation(.default) {
                color = (color == Color.white) ? category.color : Color.white
            }
        }, label: {
            ZStack (alignment: .top) {
                color.cornerRadius(7)
                Image("\(category.icon)_Icon").offset(y: 90)
                Text(category.description).lineLimit(4).multilineTextAlignment(.center).padding(.horizontal, 8).padding(.vertical, 8)
            }
        }).foregroundColor(.black)
    }
}