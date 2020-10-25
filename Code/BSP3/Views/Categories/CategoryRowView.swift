import SwiftUI

struct CategoryRowView: View {
    
    let category: Category
    let hideSeparator: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                Text(category.name).font(.title)
                Image("arrow_right").padding(.top, 4)
            }
            HStack (spacing: 20) {
                Image("\(category.icon_name)_Icon")
                Text(category.description).font(.system(size: 14)).multilineTextAlignment(.leading).lineLimit(2)
            }.padding(10)
            if !hideSeparator {
                Rectangle()
                    .frame(height: 1, alignment: .bottom)
                    .foregroundColor(Color.black.opacity(0.5))
            }
        }
        .navigationBarTitle("Accueil")
    }
}
