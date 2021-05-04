import SwiftUI
import CarBode
import AVFoundation
import PermissionsSwiftUI

struct Scanner: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @State var product: Product?
    @State var scannerIsActive: Bool = true
    @State var askPermissions: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                CameraNotAllowedView()
                if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized {
                    CBScanner(supportBarcode: .constant([.qr]), mockBarCode: .constant(BarcodeData(value: "2354896578839", type: .qr)), isActive: $scannerIsActive) { search in
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
                    }
                    if let product = self.product {
                        VStack {
                            Spacer()
                            NavigationLink(destination: ProductView(product: product, category: nil)) {
                                ProductScannedView(product: product).foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(7)
                                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 5)
                                    .padding(.horizontal, 20)
                            }.padding(.bottom, 130)
                            .navigationBarTitle(NSLocalizedString("BACK", lang: UserSettings.language))
                        }
                    }
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
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

