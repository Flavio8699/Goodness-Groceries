import SwiftUI

struct BlueButton: View {
    
    private let label: String
    private let action : () -> Void
    
    init(label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(self.label)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color("LightBlue"))
            .cornerRadius(10)
        }
    }
}
