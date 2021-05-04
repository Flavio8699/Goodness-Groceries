import SwiftUI

struct ProductIndicatorRowView: View {
    
    let indicator: Indicator
    @EnvironmentObject var PopupManager: PopupManager
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        HStack (spacing: 12) {
            Image(indicator.icon_name).frame(width: 50)
            VStack (alignment: .leading) {
                Text(NSLocalizedString(indicator.name, lang: UserSettings.language)).font(.headline).fixedSize(horizontal: false, vertical: true)
                Text(NSLocalizedString(indicator.product_description ?? "", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
            Image(systemName: "info.circle").foregroundColor(Color("GG_D_Blue")).font(.system(size: 20))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            PopupManager.currentPopup = .indicator(indicator: indicator)
            impactFeedback(.medium)
        }
        Divider().padding(.leading, 62)
    }
}
