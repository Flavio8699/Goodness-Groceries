import SwiftUI
import CarBode
import QGrid

struct Welcome_page1: View {
    
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
                BlueButton(label: "Suivant", action: {
                    withAnimation {
                        UserSettings.nextStep()
                    }
                })
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct Welcome_page2: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @State private var isPresentingScanner: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.bottom, 100)
                .padding(.top, 80)
            
            TextField("Identifiant", text: $UserSettings.clientID).keyboardType(.numberPad)

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
            
            BlueButton(label: "Suivant", action: {
                login()
            })
            
            Spacer()
            
            Image("partner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 30)
        }.padding(.horizontal)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Format incorrect"), message: Text("Il faut avoir exactement 13 chiffres!"), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: self.$isPresentingScanner) {
            CBScanner(supportBarcode: [.ean13])
                .interval(delay: 5.0)
                .found {
                    hideKeyboard()
                    self.isPresentingScanner = false
                    UserSettings.clientID = $0
                    withAnimation {
                        UserSettings.nextStep()
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    func login() {
        if(UserSettings.clientID.count != 13) {
            showAlert.toggle()
        } else {
            hideKeyboard()
            withAnimation {
                UserSettings.nextStep()
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
                .frame(width: 150)
                .padding(10)
            
            VStack (alignment: .center, spacing: 30) {
                Text("Quel consommateur êtes-vous?").font(.title)
                Text("Dites-nous ce qui compte pour vous afin de personnaliser votre expérience.")
                Image("hand")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                Bullets(step: 1, of: 3)
                BlueButton(label: "Suivant", action: {
                    withAnimation {
                        UserSettings.nextStep()
                    }
                })
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct Welcome_page4: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var welcomeVM = WelcomeViewModel()
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(10)
            
            VStack (alignment: .center, spacing: 30) {
                Text("Prêt? Allons-y!").font(.title)
                Text("Quels types de produits achetez-vous exclusivement?")
                QGrid(welcomeVM.productCategories, columns: 2, vPadding: 0, hPadding: 0, isScrollable: false) {
                    WelcomeProductCategoryCell(category: $0)
                }
                Bullets(step: 2, of: 3)
                BlueButton(label: "Suivant", action: {
                    withAnimation {
                        UserSettings.nextStep()
                    }
                })
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct Welcome_page5: View {
    
    @EnvironmentObject var UserSettings: UserSettings
    @StateObject var welcomeVM = WelcomeViewModel()
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(10)
            
            VStack (alignment: .center, spacing: 30) {
                Text("Quand je fais des courses, le plus important est de ...").font(.title)
                QGrid(welcomeVM.categories, columns: 2, vPadding: 0, hPadding: 0, isScrollable: false) {
                    WelcomeCategoryCell(category: $0)
                }
                Bullets(step: 3, of: 3)
                BlueButton(label: "Suivant", action: {
                    withAnimation {
                        UserSettings.nextStep()
                        UserSettings.requestAccess()
                    }
                })
            }
            Spacer()
        }.padding(.horizontal)
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
            
            VStack (alignment: .center, spacing: 20) {
                Text("Scannez un produit").font(.title)
                Text("Munissez vous de votre Smartphone durant vos courses afin de scanner les QR codes présents sur un sélection de produits.")
                    .frame(height: 80)
                Image("scan").frame(width: 205, height: 210)
                Bullets(step: 1, of: 2)
                HStack {
                    Spacer()
                    BlueButton(label: "Suivant", action: {
                        withAnimation {
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

struct Welcome_page7: View {
    @EnvironmentObject var UserSettings: UserSettings
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(10)
            
            VStack (alignment: .center, spacing: 20) {
                Text("Consultez les indicateurs qui comptent pour vous").font(.title).frame(height: 70)
                Text("Pour des achats plus responsables, il ne vous reste plus qu'à profiter des informations disponibles our chaque produit.")
                    .frame(height: 80)
                Image("list").frame(width: 205, height: 210)
                Bullets(step: 2, of: 2)
                HStack {
                    Spacer()
                    BlueButton(label: "Suivant", action: {
                        withAnimation {
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

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Welcome_page6().environmentObject(UserSettings())
            Welcome_page7().environmentObject(UserSettings())
        }
    }
}
