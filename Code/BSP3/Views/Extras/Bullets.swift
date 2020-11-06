import SwiftUI

struct Bullets: View {
    
    private let step: Int
    private let of: Int
    
    init(step: Int, of: Int) {
        self.step = step
        self.of = of
    }
    
    var body: some View {
        HStack (alignment: .center) {
            Spacer()
            ForEach((1...of), id: \.self) {
                Circle()
                    .size(width: 12, height: 12)
                    .frame(width: 10, height: 12)
                    .foregroundColor(self.step == $0 ? Color("LightBlue") : Color("LightGray"))
            }
            Spacer()
        }
    }
}
