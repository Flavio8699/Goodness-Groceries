import SwiftUI

struct BlueButton: View {
    
    private let label: String
    private let action : () -> Void
    private var disabled: Bool = false
    
    init(label: String, disabled: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.disabled = disabled
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
            .background(disabled ? Color(.systemGray3) : Color("GG_D_Blue"))
            .cornerRadius(10)
        }
        .disabled(disabled)
    }
}
