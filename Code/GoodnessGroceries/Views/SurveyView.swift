import SwiftUI
import SDWebImageSwiftUI

struct SurveyView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @StateObject var surveyVM = SurveyViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        if UserSettings.productsToReview.count > 0 {
            if let product = productsVM.products.filter({ $0.code == UserSettings.productsToReview.first }).first {
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (alignment: .leading, spacing: 15) {
                        Text("Quels indicateurs vous ont amenné à choisir le produit suivant?")
                        
                        HStack (alignment: .top, spacing: 15) {
                            WebImage(url: URL(string: product.image_url)).resizable().frame(width: 100, height: 100).cornerRadius(7)
                            VStack (alignment: .leading, spacing: 15) {
                                Text(product.name).bold().font(.headline)
                                GeometryReader { geometry in
                                    IndicatorsView(geometry: geometry, indicators: product.getIndicators())
                                }
                            }
                        }
                        Divider()
                        
                        VStack (spacing: 30) {
                            VStack (spacing: 15) {
                                ForEach(product.getIndicators(), id: \.self) { indicator in
                                    Button(action: {
                                        surveyVM.handleSelection(for: indicator.icon_name)
                                        hideKeyboard()
                                    }) {
                                        HStack(alignment: .center, spacing: 40) {
                                            Image(indicator.icon_name)
                                            HStack {
                                                Text(NSLocalizedString(indicator.name, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                                                Spacer(minLength: 0)
                                            }
                                            Image(systemName: surveyVM.selected.contains(indicator.icon_name) ? "checkmark.square" : "square")
                                                .renderingMode(.original)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                        }.foregroundColor(Color.black)
                                    }
                                }
                            }
                            
                            Button(action: {
                                surveyVM.handleSelection(for: "price")
                                hideKeyboard()
                            }) {
                                HStack(alignment: .center, spacing: 40) {
                                    HStack {
                                        Text("Prix").font(.headline)
                                        Spacer(minLength: 0)
                                    }
                                    Image(systemName: surveyVM.selected.contains("price") ? "checkmark.square" : "square")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                }.foregroundColor(Color.black)
                            }
                            
                            VStack (alignment: .leading) {
                                Button(action: {
                                    surveyVM.handleSelection(for: "otherreason")
                                    hideKeyboard()
                                }) {
                                    HStack(alignment: .center, spacing: 40) {
                                        HStack {
                                            Text("Autre raison..").font(.headline)
                                            Spacer(minLength: 0)
                                        }
                                        Image(systemName: surveyVM.selected.contains("otherreason") ? "checkmark.square" : "square")
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }.foregroundColor(Color.black)
                                }
                                
                                HStack {
                                    TextField("Autre raison..", text: $surveyVM.otherreason)
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                }
                                .background(Color(.systemGray5))
                                .cornerRadius(6)
                            }
                        }
                            
                        BlueButton(label: NSLocalizedString("Suivant", lang: UserSettings.language), action: {
                            withAnimation(.default) {
                                hideKeyboard()
                                surveyVM.sendProductFeedback(for: UserSettings.clientID)
                            }
                        }).padding(.vertical, 20)
                    }
                    .padding(.top, 15)
                    .padding(.horizontal)
                }
            }
        } else {
            ProgressView().onAppear {
                PopupManager.currentPopup = .message(title: "Merci!", message: "thank you message...")
                UserSettings.showSurvey = false
            }
        }
    }
}
