import SwiftUI

struct CategoryRowView: View {
    
    let category: Category
    let hideSeparator: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            HStack {
                Text(self.category.name).font(.title)
                Image("arrow_right").padding(.top, 4)
            }
            HStack (spacing: 20) {
                Image("\(self.category.name)_Icon")
                Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.").font(.system(size: 14)).multilineTextAlignment(.leading).lineLimit(2)
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
