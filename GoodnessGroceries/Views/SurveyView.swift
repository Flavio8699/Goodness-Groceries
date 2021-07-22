import SwiftUI

struct SurveyView: View {
    
    @StateObject var productsVM = ProductsViewModel()
    @StateObject var surveyVM = SurveyViewModel()
    @EnvironmentObject var UserSettings: UserSettings
    @EnvironmentObject var PopupManager: PopupManager
    
    var body: some View {
        if UserSettings.productsToReview.count > 0 {
            if let product = productsVM.products.filter({ $0.code == UserSettings.productsToReview.first }).first {
                ScrollView (.vertical, showsIndicators: true) {
                    VStack (alignment: .leading, spacing: 15) {
                        Text(NSLocalizedString("SURVEY_PAGE_TEXT", lang: UserSettings.language))
    
                        Text(NSLocalizedString(product.name, lang: UserSettings.language)).font(.headline)
                        HStack (alignment: .top) {
                            ProductImageView(url: product.image_url)
                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                                .frame(width: 1, height: 100)
                                .foregroundColor(Color(.systemGray3))
                            IndicatorIconsView(indicators: product.getIndicators())
                        }
                        Divider()
                        
                        VStack (spacing: 30) {
                            VStack (spacing: 15) {
                                ForEach(product.getIndicators(), id: \.self) { indicator in
                                    HStack(alignment: .center, spacing: 30) {
                                        Image(indicator.icon_name).frame(width: 50)
                                        .onTapGesture {
                                            PopupManager.currentPopup = .indicator(indicator: indicator)
                                            impactFeedback(.medium)
                                        }
                                        Button(action: {
                                            surveyVM.handleSelection(for: indicator.id)
                                            hideKeyboard()
                                        }) {
                                            HStack {
                                                Text(NSLocalizedString(indicator.name, lang: UserSettings.language)).fixedSize(horizontal: false, vertical: true)
                                                Spacer(minLength: 0)
                                                Image(systemName: surveyVM.selected.contains(indicator.id) ? "checkmark.square" : "square")
                                                    .renderingMode(.original)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 20, height: 20)
                                            }
                                        }
                                    }.foregroundColor(Color.black)
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
                            
                        BlueButton(label: NSLocalizedString("CONTINUE", lang: UserSettings.language), action: {
                            withAnimation(.default) {
                                hideKeyboard()
                                surveyVM.sendProductFeedback(for: UserSettings.clientID, product: product.code)
                            }
                        }).padding(.vertical, 20)
                    }
                    .padding()
                }
            }
        } else {
            ProgressView().onAppear {
                PopupManager.currentPopup = .thankyou
                UserSettings.showSurvey = false
            }
        }
    }
}
