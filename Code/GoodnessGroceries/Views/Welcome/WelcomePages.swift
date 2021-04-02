import SwiftUI
import CarBode
import AVFoundation
import QGrid

struct Welcome_page1: View {
    
    @EnvironmentObject var UserSettings: UserSettings

    var body: some View {
        VStack {
            HStack (spacing: 25) {
                Image("GG-Logo-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                Image("uni_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
            }.padding(.bottom, 40)
            
            VStack (alignment: .leading, spacing: 30) {
                Text(NSLocalizedString("WELCOME_PAGE_1_TITLE", lang: UserSettings.language)).font(.title)
                Text(NSLocalizedString("WELCOME_PAGE_1_TEXT", lang: UserSettings.language))
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}

struct Welcome_page2: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @State private var isPresentingScanner: Bool = false
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .padding(.bottom, 100)
            
            TextField(NSLocalizedString("CLIENT_ID", lang: UserSettings.language), text: $UserSettings.clientID).keyboardType(.numberPad)

            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(.gray)
                .padding(.bottom, 25)
            
            Text(NSLocalizedString("OR", lang: UserSettings.language)).font(.footnote)
            
            Button(action: {
                self.isPresentingScanner = true
            }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "qrcode.viewfinder")
                    Text(NSLocalizedString("SCAN_DIRECTLY", lang: UserSettings.language))
                    Spacer()
                }.foregroundColor(Color("GG_D_Blue"))
            }).padding()
            
            BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                login()
            })
            
            Spacer()
            
            Image("partner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 30)
        }.padding()
        .sheet(isPresented: self.$isPresentingScanner) {
            CBScanner(supportBarcode: .constant([.ean13]), scanInterval: .constant(0.0), mockBarCode: .constant(BarcodeData(value: "0000000001234", type: .ean13))) {
                hideKeyboard()
                self.isPresentingScanner = false
                UserSettings.clientID = $0.value
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func login() {
        if(UserSettings.clientID.count != 13) {
            PopupManager.currentPopup = .message(title: NSLocalizedString("WRONG_FORMAT_ALERT_TITLE", lang: UserSettings.language), message: NSLocalizedString("WRONG_FORMAT_ALERT_TEXT", lang: UserSettings.language))
            notificationFeedback(.warning)
        } else {
            hideKeyboard()
            withAnimation {
                UserSettings.step += 1
            }
        }
    }

}

struct Welcome_page3: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .padding(.bottom, 20)
            
            VStack (alignment: .leading, spacing: 30) {
                Text(NSLocalizedString("WELCOME_PAGE_3_TITLE", lang: UserSettings.language)).font(.title)
                Text(NSLocalizedString("WELCOME_PAGE_3_TEXT", lang: UserSettings.language))
                Spacer(minLength: 0)
                HStack {
                    Spacer()
                    Image("hand")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    Spacer()
                }
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}

struct Welcome_page4: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var welcomeVM = WelcomeViewModel()
    @StateObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
            
            VStack (alignment: .center, spacing: 10) {
                Text(NSLocalizedString("WELCOME_PAGE_4_TITLE", lang: UserSettings.language)).font(.title)
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(categoriesVM.categories) {
                        WelcomeCategoryCell(category: $0)
                    }
                }
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}

struct Welcome_page5: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var welcomeVM = WelcomeViewModel()
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
            
            VStack (alignment: .center, spacing: 10) {
                Text(NSLocalizedString("WELCOME_PAGE_5_TITLE", lang: UserSettings.language)).font(.title)
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(welcomeVM.productCategories) {
                        WelcomeProductCategoryCell(category: $0)
                    }
                }
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    login()
                })
            }
        }.padding()
    }
    
    func login() {
        if(UserSettings.clientID.count != 13) {
            PopupManager.currentPopup = .message(title: NSLocalizedString("WRONG_FORMAT_ALERT_TITLE", lang: UserSettings.language), message: NSLocalizedString("WRONG_FORMAT_ALERT_TEXT", lang: UserSettings.language))
            notificationFeedback(.warning)
        } else {
            hideKeyboard()
            withAnimation {
                welcomeVM.requestAccess(for: UserSettings)
            }
        }
    }
}

struct Welcome_page6: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(10)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("WELCOME_PAGE_6_TITLE", lang: UserSettings.language)).font(.title)
                Text(NSLocalizedString("WELCOME_PAGE_6_TEXT", lang: UserSettings.language))
                Spacer(minLength: 0)
                Image("scan").frame(width: 205, height: 210)
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}

struct Welcome_page7: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(10)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("WELCOME_PAGE_7_TITLE", lang: UserSettings.language)).font(.title).fixedSize(horizontal: false, vertical: true)
                Text(NSLocalizedString("WELCOME_PAGE_7_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 0)
                Image("list").frame(width: 205, height: 210)
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}
