import Foundation
import SwiftUI

extension AnyTransition {
    static var viewTransition: AnyTransition {
        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    }
}
