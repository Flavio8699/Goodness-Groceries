import Foundation

class SurveyViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var selected: Set<String> = []
    @Published var otherreason: String = "" {
        didSet {
            if !selected.contains("otherreason") && otherreason != ""{
                if selected.count > 1 {
                    selected.removeFirst()
                }
                selected.insert("otherreason")
            }
        }
    }
    
    func sendProductFeedback(for participant_id: String, product: String) {
        var selected_indicator_main_id = "null"
        var selected_indicator_secondary_id = "null"
        var free_text_indicator = "null"
        var price_checkbox_selected = false
        
        for (i, indicator) in selected.enumerated() {
            switch indicator {
                case "price":
                    price_checkbox_selected = true
                case "otherreason":
                    free_text_indicator = otherreason
                default:
                    if i == 0 {
                        selected_indicator_main_id = indicator
                    } else {
                        selected_indicator_secondary_id = indicator
                    }
            }
        }
        
        NetworkManager.shared.sendProductFeedback(for: participant_id, product_ean: product, selected_indicator_main_id: selected_indicator_main_id, selected_indicator_secondary_id: selected_indicator_secondary_id, free_text_indicator: free_text_indicator, price_checkbox_selected: price_checkbox_selected) { result in
            switch result {
                case .success(_):
                    self.nextProduct()
                    break
                    
                case .failure(let type):
                    appDelegate().popupManager.currentPopup = .error(type)
                    break
            }
        }
    }
    
    func nextProduct() {
        UserSettings.shared.productsToReview.removeFirst()
        otherreason = ""
        selected.removeAll()
    }
    
    func handleSelection(for choice: String) {
        if selected.contains(choice) {
            selected.remove(choice)
            if choice == "otherreason" {
                otherreason = ""
            }
        } else {
            if selected.count > 1 {
                if selected.first == "otherreason" {
                    otherreason = ""
                }
                selected.removeFirst()
            }
            selected.insert(choice)
        }
    }
}
