import SwiftUI

struct IndicatorsHelpView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @StateObject var categoriesVM = CategoriesViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @State var selected: Set<Indicator> = []
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: true) {
            VStack (alignment: .leading, spacing: 10) {
                ForEach(categoriesVM.categories, id: \.self) { category in
                    Section(header: Text(NSLocalizedString(category.name, lang: UserSettings.language)).font(.system(size: 20))) {
                        let indicators = category.getIndicators()
                        ForEach(indicators, id: \.self) { ind in
                            VStack (alignment: .leading, spacing: 10) {
                                HStack (spacing: 15) {
                                    Image(ind.icon_name).frame(width: 50)
                                    Text(NSLocalizedString(ind.name, lang: UserSettings.language)).font(.system(size: 20)).fixedSize(horizontal: false, vertical: true)
                                    Spacer(minLength: 0)
                                    Image("arrow_right").rotationEffect(.degrees(selected.contains(ind) ? 90 : 0))
                                }
                                if selected.contains(ind) {
                                    Text(NSLocalizedString(ind.general_description, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                                }
                                Divider().padding(.leading, ind == indicators.last ? 0 : 65)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.15)) {
                                    if selected.contains(ind) {
                                        selected.remove(ind)
                                    } else {
                                        selected.insert(ind)
                                    }
                                }
                            }
                        }
                    }
                }
            }.padding()
        }.navigationBarTitle(NSLocalizedString("HELP_PAGE_BUTTON_1", lang: UserSettings.language), displayMode: .inline)
    }
}
