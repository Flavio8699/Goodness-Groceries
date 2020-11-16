import SwiftUI
import CarBode

struct Scanner: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @State var product: Product?
    
    var body: some View {
        NavigationView {
            ZStack {
                CBScanner(supportBarcode: [.qr])
                    .interval(delay: 1.0)
                    .found { search in
                        if let product = self.productsVM.products.first(where: { $0.code == search }) {
                            if self.product != product {
                                    self.product = product
                                
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
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
                                .navigationBarTitle("Retour")
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
