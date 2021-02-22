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
            
            VStack (alignment: .leading, spacing: 30) {
                Text("WELCOME_PAGE_1_TITLE").font(.title)
                Text("Nous voulons être transparents et vous permettre d'acheter les produits qui vous correspondent. C'est pourquoi nous avons développé l'application Goodness Groceries. Celle-ci vous permettra de consulter une multitude de données spécifiques à un produit et de le comparer à d'autres avant d'effectuer vos achats.")
                BlueButton(label: "Suivant", action: {
                    withAnimation {
                        UserSettings.step += 1
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
                .interval(delay: 0)
                .found {
                    hideKeyboard()
                    self.isPresentingScanner = false
                    UserSettings.clientID = $0
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
                UserSettings.step += 1
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
                BlueButton(label: "Suivant", action: {
                    withAnimation {
                        UserSettings.step += 1
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
                BlueButton(label: "Suivant", action: {
                    withAnimation {
                        UserSettings.step += 1
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
    @StateObject var categoriesVM = CategoriesViewModel()
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Image("uni_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(10)
            
            VStack (alignment: .center, spacing: 30) {
                Text("Quand je fais des courses, le plus important est de ...").font(.title)
                QGrid(categoriesVM.categories, columns: 2, vPadding: 0, hPadding: 0, isScrollable: false) {
                    WelcomeCategoryCell(category: $0)
                }
                BlueButton(label: "Suivant", action: {
                    login()
                })
            }
            Spacer()
        }.padding(.horizontal)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Format incorrect"), message: Text("Votre identifiant n'est pas correct!"), dismissButton: .default(Text("Ok")))
        }
    }
    
    func login() {
        if(UserSettings.clientID.count != 13) {
            showAlert.toggle()
        } else {
            hideKeyboard()
            withAnimation {
                welcomeVM.requestAccess(for: UserSettings.clientID) { result in
                    switch result {
                        case .success(_):
                            UserSettings.step += 1
                            UserSettings.statusRequested = true
                            break
                            
                        case .failure(_):
                            UserSettings.networkError = true
                            break
                    }
                }
            }
        }
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
                Text("Munissez vous de votre Smartphone durant vos courses afin de scanner les QR codes présents sur une sélection de produits.")
                    .frame(height: 80)
                Spacer(minLength: 0)
                Image("scan").frame(width: 205, height: 210)
                Spacer(minLength: 0)
                HStack {
                    Spacer()
                    BlueButton(label: "Suivant", action: {
                        withAnimation {
                            UserSettings.step += 1
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
                Text("Pour des achats plus responsables, il ne vous reste plus qu'à profiter des informations disponibles sur chaque produit.")
                    .frame(height: 80)
                Spacer(minLength: 0)
                Image("list").frame(width: 205, height: 210)
                Spacer(minLength: 0)
                HStack {
                    Spacer()
                    BlueButton(label: "Suivant", action: {
                        withAnimation {
                            UserSettings.step += 1
                        }
                    })
                    Spacer()
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}
