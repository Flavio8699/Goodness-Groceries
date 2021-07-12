import SwiftUI

struct ProductIndicatorRowView: View {
    
    let productIndicator: ProductIndicator
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        if let indicator = productIndicator.getIndicator() {
            HStack (spacing: 12) {
                Image(indicator.icon_name).frame(width: 50)
                Text(NSLocalizedString(indicator.name, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 0)
                Image(systemName: "info.circle").foregroundColor(Color("GG_D_Blue")).font(.system(size: 20))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                PopupManager.currentPopup = .productIndicator(productIndicator: productIndicator)
                impactFeedback(.medium)
            }
            Divider().padding(.leading, 62)
        }
    }
}
