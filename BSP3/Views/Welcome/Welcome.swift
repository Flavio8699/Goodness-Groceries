import SwiftUI
import CarBode

struct Welcome_page1: View {
    @EnvironmentObject var UserSettings: UserSettings
    @ObservedObject var welcomeVM = WelcomeViewModel()
    @State private var clientID: String = ""
    @State private var alert: Bool = false
    @State private var isPresentingScanner: Bool = false
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.bottom, 100)
                .padding(.top, 80)
            
            TextField("Identifiant", text: $clientID)
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(.gray)
                .padding(.bottom, 25)
            
            Text("ou").font(.footnote)
            
            Button(action: {
                self.isPresentingScanner = true
            }, label: {
                HStack {
                    Spacer()
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scanner directement")
                    Spacer()
                }
            }).padding()
            
            BlueButton(label: "Sign In", action: {
                self.hideKeyboard()
                login()
            })
            
            Spacer()
            
            Image("partner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 30)
        }.padding(.horizontal)
        .alert(isPresented: self.$alert) {
            Alert(title: Text("verification step..."))
        }
        .sheet(isPresented: self.$isPresentingScanner) {
            CBScanner(supportBarcode: [.qr, .code128, .code39, .code93, .upce])
                .interval(delay: 5.0)
                .found {
                    self.isPresentingScanner = false
                    self.clientID = $0
                    login()
                }
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func login() {
        welcomeVM.signIn(user: self.clientID, { result in
            switch result {
            case .success(let user):
                self.UserSettings.setUser(user: user, clientID: clientID)
                self.UserSettings.showWelcome = false
            case .failure(_):
                self.alert.toggle()
            }
        })
    }
}

struct Welcome_page2: View {
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.bottom, 50)
                .padding(.top, 30)
            VStack (alignment: .center, spacing: 30) {
                Text("Bienvenue dans GreenBot!").font(.title)
                Text("Nous voulons être transparents et vous permettre d'acheter les produits qui vous correspondent. C'est pourquoi nous avons développé l'application GreenBot. Celle-ci vous permettra de consulter une multitude de données spécifiques à un produit et de le comparer à d'autres avant d'effectuer vos achats.")
                Bullets(step: self.UserSettings.step)
                HStack {
                    Spacer()
                    BlueButton(label: "Compris!", action: {
                        withAnimation(.default) {
                            self.UserSettings.step += 1
                        }
                    })
                    Spacer()
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct Welcome_page3: View {
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            Image("scan")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250)
                .padding(.bottom, 50)
                .padding(.top, 30)
            VStack (alignment: .center, spacing: 30) {
                Text("Scannez un produit!").font(.title)
                Text("Scannez un produit pour obtenir toutes les informations. Cela rapporte aussi de l'exp à votre niveau.")
                Bullets(step: self.UserSettings.step)
                HStack {
                    Spacer()
                    BlueButton(label: "Compris!", action: {
                        withAnimation(.default) {
                            self.UserSettings.step += 1
                        }
                    })
                    Spacer()
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct Welcome_page4: View {
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.bottom, 50)
                .padding(.top, 30)
            VStack (alignment: .center, spacing: 20) {
                Text("Gagnez des niveaux!").font(.title).fixedSize(horizontal: false, vertical: true)
                Text("Effectuer des actions comme faire des scans et des comparaisons. Réussir des hauts faits!").fixedSize(horizontal: false, vertical: true)
                Text("Pourquoi gagner des niveaux?").font(.title).fixedSize(horizontal: false, vertical: true)
                Text("Effectuer des actions comme faire des scans et des comparaisons. Réussir des hauts faits!").fixedSize(horizontal: false, vertical: true).padding(.bottom, 18)
                Bullets(step: self.UserSettings.step)
                HStack {
                    Spacer()
                    BlueButton(label: "Compris!", action: {
                        withAnimation(.default) {
                            self.UserSettings.step += 1
                            self.UserSettings.showWelcome = false
                        }
                    })
                    Spacer()
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}
