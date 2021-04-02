import Foundation

class SurveyViewModel: ObservableObject {
    
    private var NetworkManager = GoodnessGroceries.NetworkManager()
    @Published var showAlert: Bool = false
    @Published var selected = [String]()
    @Published var otherreason: String = "" {
        didSet {
            if !selected.contains("otherreason") && otherreason != ""{
                if selected.count > 1 {
                    selected.removeFirst()
                }
                selected.append("otherreason")
            }
        }
    }
    
    func sendProductFeedback(for participant_id: String) {
        NetworkManager.sendProductFeedback(for: participant_id, product_ean: "2354896578839", selected_indicator_main_id: "test1", selected_indicator_secondary_id: "test2", free_text_indicator: "freetext", price_checkbox_selected: false) { result in
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
        appDelegate().UserSettings.productsToReview.removeFirst()
        otherreason = ""
        selected.removeAll()
    }
    
    func handleSelection(for choice: String) {
        if selected.contains(choice) {
            selected.removeAll { $0 == choice }
        } else {
            if selected.count > 1 {
                selected.removeFirst()
            }
            selected.append(choice)
        }
    }
}
