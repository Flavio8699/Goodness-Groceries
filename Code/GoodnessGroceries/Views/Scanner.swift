import SwiftUI
import CarBode
import AVFoundation

struct Scanner: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @State var product: Product?
    @State var scannerActive: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                CBScanner(supportBarcode: .constant([.qr]), mockBarCode: .constant(BarcodeData(value: "2354896578839", type: .qr)), isActive: $scannerActive) { search in
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
                            ProductScannedView(product: product).padding(.bottom, 70)
                                .navigationBarTitle(NSLocalizedString("BACK", lang: UserSettings.language))
                        }
                    }
                }
            }
            .onAppear {
                scannerActive = true
            }
            .onDisappear {
                scannerActive = false
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
