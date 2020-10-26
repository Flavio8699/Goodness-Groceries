import SwiftUI

struct StatusRequestedView: View {
    
    private var NetworkManager = BSP3.NetworkManager()
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 30) {
                Text("Votre demande a été envoyée et sera traité le plus vite possible. Merci pour votre compréhension.")
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.circle").foregroundColor(.green).font(.system(size: 100))
                    Spacer()
                }
                BlueButton(label: "Renvoyer une demande", action: {
                    self.showAlert.toggle()
                    NetworkManager.requestUserAccess(for: "1")
                }).padding(.top, 20)
                Spacer()
            }.padding()
            .navigationBarTitle("Accès demandé")
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Accès demandé"), message: Text("Votre demandé a été envoyée!"), dismissButton: .default(Text("Merci")))
        }
    }
}
