import SwiftUI
import CarBode
import AVFoundation
import PermissionsSwiftUI
import QGrid

struct Welcome_page1: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager

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
            
            VStack (alignment: .center, spacing: 30) {
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
    @State var isPresentingScanner: Bool = false
    @State var askPermissions: Bool = true
    
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
                Image("pall_center")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            }.padding(.bottom, 120)
            

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
        }.padding()
        .sheet(isPresented: self.$isPresentingScanner) {
            ZStack {
                CameraNotAllowedView()
                if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized || !askPermissions {
                    CBScanner(supportBarcode: .constant([.ean13]), scanInterval: .constant(0.0), mockBarCode: .constant(BarcodeData(value: "0000000001234", type: .ean13))) {
                        hideKeyboard()
                        self.isPresentingScanner = false
                        UserSettings.clientID = $0.value
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .JMModal(showModal: $askPermissions, for: [.camera], autoDismiss: true, autoCheckAuthorization: true)
            .changeHeaderTo(NSLocalizedString("PERMISSIONS_MODAL_TITLE", lang: UserSettings.language))
            .changeHeaderDescriptionTo(NSLocalizedString("PERMISSIONS_MODAL_HEADER", lang: UserSettings.language))
            .changeBottomDescriptionTo(NSLocalizedString("PERMISSIONS_MODAL_FOOTER", lang: UserSettings.language))
            .setPermissionComponent(for: .camera, image: AnyView(Image(systemName: "camera.fill")), title: NSLocalizedString("PERMISSIONS_MODAL_CAMERA_TITLE", lang: UserSettings.language), description: NSLocalizedString("PERMISSIONS_MODAL_CAMERA_DESCRIPTION", lang: UserSettings.language))
            .setAccentColor(toPrimary: Color("GG_D_Blue"), toTertiary: Color(.systemRed))
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
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var categoriesVM = CategoriesViewModel()
    
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
            }.padding(.bottom, 20)
            
            VStack (alignment: .center, spacing: 0) {
                Text(NSLocalizedString("WELCOME_PAGE_3_TITLE", lang: UserSettings.language)).font(.title)
                Text(NSLocalizedString("WELCOME_PAGE_3_TEXT", lang: UserSettings.language)).padding(.top, 30)
                Spacer()
                GeometryReader { geometry in
                    QGrid(categoriesVM.categories, columns: 2) { category in
                        Image(category.icon_name).resizable().frame(width: geometry.size.width*0.3, height: geometry.size.width*0.3).onTapGesture {
                            PopupManager.currentPopup = .category(category: category)
                            impactFeedback(.medium)
                        }
                    }
                }
                Spacer()
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
    @StateObject var categoriesVM = CategoriesViewModel()
    
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
            }.padding(.bottom, 20)
            
            VStack (alignment: .center, spacing: 10) {
                Text(NSLocalizedString("WELCOME_PAGE_4_TITLE", lang: UserSettings.language)).font(.system(size: 20, weight: .bold))
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(categoriesVM.categories) {
                            WelcomeCategoryCellView(category: $0)
                        }
                    }.padding(.bottom)
                    .padding(.top, 5)
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
            }.padding(.bottom, 20)
            
            VStack (alignment: .center, spacing: 10) {
                Text(NSLocalizedString("WELCOME_PAGE_5_TITLE", lang: UserSettings.language)).font(.system(size: 20, weight: .bold))
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(ProductCategory.allCases, id: \.self) {
                            WelcomeProductCategoryCellView(category: $0)
                        }
                    }.padding(.bottom)
                    .padding(.top, 5)
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

struct Welcome_page6: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var welcomeVM = WelcomeViewModel()

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
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("WELCOME_PAGE_NOTIFICATIONS_TITLE", lang: UserSettings.language)).font(.title)
                Text(NSLocalizedString("WELCOME_PAGE_NOTIFICATIONS_TEXT_1", lang: UserSettings.language))
                Text(NSLocalizedString("WELCOME_PAGE_NOTIFICATIONS_TEXT_2", lang: UserSettings.language))
                Spacer(minLength: 0)
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _,_  in
                        DispatchQueue.main.async {
                            login()
                        }
                    }
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
                welcomeVM.requestAccess()
            }
        }
    }
}

struct Welcome_page7: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @State var dataString = "123"
    @State var barcodeType = CBBarcodeView.BarcodeType.qrCode
    @State var rotate = CBBarcodeView.Orientation.up
    
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
            }.padding(.bottom, 20)
            
            VStack (alignment: .center, spacing: 30) {
                Text(NSLocalizedString("WELCOME_PAGE_6_TITLE", lang: UserSettings.language)).font(.title)
                Text(NSLocalizedString("WELCOME_PAGE_6_TEXT", lang: UserSettings.language))
                CBBarcodeView(data: $dataString, barcodeType: $barcodeType, orientation: $rotate, onGenerated: nil).frame(width: 205, height: 210).opacity(0.9)
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

struct Welcome_page8: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    @StateObject var categoriesVM = CategoriesViewModel()
    
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
            }.padding(.bottom, 20)
            
            VStack (alignment: .center, spacing: 20) {
                Text(NSLocalizedString("WELCOME_PAGE_7_TITLE", lang: UserSettings.language)).font(.title).fixedSize(horizontal: false, vertical: true)
                Text(NSLocalizedString("WELCOME_PAGE_7_TEXT", lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                Spacer()
                GeometryReader { geometry in
                    QGrid(categoriesVM.categories, columns: 2) { category in
                        Image(category.icon_name).resizable().frame(width: geometry.size.width*0.3, height: geometry.size.width*0.3).onTapGesture {
                            PopupManager.currentPopup = .category(category: category)
                            impactFeedback(.medium)
                        }
                    }
                }
                Spacer()
                BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                    withAnimation {
                        UserSettings.step += 1
                    }
                })
            }
        }.padding()
    }
}
