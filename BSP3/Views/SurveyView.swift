import SwiftUI

struct SurveyView: View {
    
    let products: [Int]
    
    var body: some View {
        /*
         if let product = ProductsViewModel().products.first(where: { $0.code == String(i) }) {
             self.surveyProducts!.append(product)
         }
         */
        /*ForEach(self.products, id: \.self) { product in
            Text(product.name)
        }*/
        Text("survey")
    }
}
