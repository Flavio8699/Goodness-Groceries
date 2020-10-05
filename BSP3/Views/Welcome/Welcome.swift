import SwiftUI
import CarBode

struct Welcome_page1: View {
    @EnvironmentObject var UserSettings: UserSettings
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
            
            TextField("Identifiant", text: $UserSettings.clientID)
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
                hideKeyboard()
                login()
            })
            
            Spacer()
            
            Image("partner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 30)
        }.padding(.horizontal)
        .alert(isPresented: self.$alert) {
            Alert(title: Text("something wrong..."))
        }
        .sheet(isPresented: self.$isPresentingScanner) {
            CBScanner(supportBarcode: [.ean13])
                .interval(delay: 5.0)
                .found {
                    self.isPresentingScanner = false
                    UserSettings.clientID = $0
                    login()
                }
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func login() {
        UserSettings.signIn { result in
            switch result {
            case .success(let user):
                UserSettings.setUser(user: user)
                UserSettings.nextStep()
            case .failure(_):
                alert.toggle()
            }
        }
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
                Bullets(step: UserSettings.getStep())
                HStack {
                    Spacer()
                    BlueButton(label: "Compris!", action: {
                        withAnimation(.default) {
                            UserSettings.nextStep()
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
                Bullets(step: UserSettings.getStep())
                HStack {
                    Spacer()
                    BlueButton(label: "Compris!", action: {
                        withAnimation(.default) {
                            UserSettings.nextStep()
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
                Bullets(step: UserSettings.getStep())
                HStack {
                    Spacer()
                    BlueButton(label: "Compris!", action: {
                        withAnimation(.default) {
                            UserSettings.nextStep()
                            UserSettings.updateWelcome()
                        }
                    })
                    Spacer()
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}
