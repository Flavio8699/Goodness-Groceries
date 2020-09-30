import SwiftUI
import CarBode

struct Scanner: View {
    
    @ObservedObject var productsVM = ProductsViewModel()
    @State var product: Product?
    var notifs = NotificationsManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                CBScanner(supportBarcode: [.qr])
                    .interval(delay: 1.0)
                    .found { search in
                        if let product = self.productsVM.products.first(where: { $0.code == search }) {
                            withAnimation() {
                                self.product = product
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
                        NavigationLink(destination: Text("product view")) {
                            ProductScannedView(product: product).padding(.bottom, 70)
                        }
                    }
                }
                Button(action: {
                    self.notifs.sendNotification()
                }, label: {
                    Text("tessssssst")
                })
            }.edgesIgnoringSafeArea(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
