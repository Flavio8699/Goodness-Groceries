import SwiftUI
import MapKit

struct ProductView: View {
    
    let product: Product
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 49.623874, longitude: 6.052060), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    var body: some View {
        Map(coordinateRegion: $region).frame(height: 150)
        ForEach(product.indicators, id: \.self) { indicator in
            Text(indicator.icon)
        }
    }
}
