import SwiftUI
import CarBode
import AVFoundation
import PermissionsSwiftUI

struct Scanner: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @State var product: Product?
    @State var scannerIsActive: Bool = true
    @State var torchLightIsActive: Bool = false
    @State var askPermissions: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading) {
                CameraNotAllowedView()
                if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized || !askPermissions {
                    CBScanner(supportBarcode: .constant([.qr]), torchLightIsOn: $torchLightIsActive, mockBarCode: .constant(BarcodeData(value: "2354896578839", type: .qr)), isActive: $scannerIsActive) { search in
                        if let product = self.productsVM.products.first(where: { $0.code == search.value }) {
                            if self.product != product {
                                self.product = product
                                notificationFeedback(.success)
                            }
                        } else {
                            withAnimation() {
                                self.product = nil
                            }
                        }
                    }.edgesIgnoringSafeArea(.all)
                    if let product = self.product {
                        VStack {
                            Spacer()
                            NavigationLink(destination: ProductView(product: product, category: nil)) {
                                ProductScannedView(product: product).foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(7)
                                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                                    .padding(.horizontal, 20)
                            }.padding(.bottom, 35)
                            .navigationBarTitle(NSLocalizedString("BACK", lang: UserSettings.language))
                        }
                    }
                    Button(action: {
                        torchLightIsActive.toggle()
                        impactFeedback(.medium)
                    }, label: {
                        ZStack {
                            Circle().foregroundColor(.white).frame(width: 50, height: 50)
                            Image(systemName: "flashlight.\(torchLightIsActive ? "on" : "off").fill").font(.system(size: 25, weight: .regular))
                        }
                    }).offset(x: 15, y: 15)
                }
            }
            .JMModal(showModal: $askPermissions, for: [.camera], autoDismiss: true, autoCheckAuthorization: true)
            .changeHeaderTo("Permissions")
            .setPermissionComponent(for: .camera, image: AnyView(Image(systemName: "camera.fill")), title: "Camera", description: "Goodness Groceries needs access to your camera to scan QR-codes")
            .setAccentColor(toPrimary: Color("GG_D_Blue"), toTertiary: Color(.systemRed))
            .onAppear {
                scannerIsActive = true
            }
            .onDisappear {
                scannerIsActive = false
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

