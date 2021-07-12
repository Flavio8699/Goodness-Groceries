import SwiftUI

struct Bullet: View {
    
    var isSelected: Bool
    let action: () -> Void
      
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Circle()
            .size(width: 12, height: 12)
            .frame(width: 10, height: 12)
            .foregroundColor(self.isSelected ? Color("GG_D_Blue") : Color(.systemGray4))
        }
    }
}
