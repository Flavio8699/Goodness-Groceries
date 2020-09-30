import SwiftUI

struct Bullets: View {
    
    private let step: Int
    
    init(step: Int) {
        self.step = step
    }
    
    var body: some View {
        HStack (alignment: .center) {
            Spacer()
            ForEach((1...3), id: \.self) {
                Circle()
                    .size(width: 12, height: 12)
                    .frame(width: 10, height: 12)
                    .foregroundColor(self.step == $0 ? Color("LightBlue") : Color("LightGray"))
            }
            Spacer()
        }
    }
}
