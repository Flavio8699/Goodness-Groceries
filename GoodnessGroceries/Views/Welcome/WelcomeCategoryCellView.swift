import SwiftUI

struct WelcomeCategoryCellView: View {
    
    let category: Category
    @State var color: Color = Color("GG_D_Blue")
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        ZStack {
            Color.white
            VStack (alignment: .leading) {
                HStack {
                    HStack {
                        Image(category.icon_name).frame(width: 60)
                        Text(NSLocalizedString(category.name, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                        Spacer(minLength: 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        PopupManager.currentPopup = .category(category: category)
                    }
                    Button(action: {
                        withAnimation(.linear(duration: 0.15)) {
                            color = (color == Color.white) ? Color("GG_D_Blue") : Color.white
                        }
                        
                        if WelcomeViewModel.selectedIndicatorCategories.contains(category.id) {
                            WelcomeViewModel.selectedIndicatorCategories.removeAll { $0 == category.id }
                        } else {
                            WelcomeViewModel.selectedIndicatorCategories.append(category.id)
                            impactFeedback(.medium)
                        }
                    }, label: {
                        ZStack (alignment: .center) {
                            if color == Color.white {
                                Color("GG_D_Blue").cornerRadius(7)
                                Image(systemName: "checkmark").foregroundColor(color).font(Font.system(size: 15, weight: .bold))
                            } else {
                                Image(systemName: "plus").foregroundColor(color).font(Font.system(size: 15, weight: .bold))
                            }
                        }.frame(width: 45, height: 45).overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color("GG_D_Blue"), lineWidth: 2.5)
                        )
                    })
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .cornerRadius(7)
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 3)
        .padding(.horizontal, 5)
        .padding(.vertical, 3)
    }
}
