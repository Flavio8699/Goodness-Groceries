import Foundation
import SwiftUI

enum ProductCategory: String, Codable, CustomStringConvertible, CaseIterable {
    case localOrganic = "local_organic"
    case importedOrganic = "imported_organic"
    case localConventional = "local_conventional"
    case importedConventional = "imported_conventional"

    var description: String {
        switch self {
            case .localOrganic: return "PRODUCT_CATEGORY_LOCAL_ORGANIC"
            case .localConventional: return "PRODUCT_CATEGORY_LOCAL_CONVENTIONAL"
            case .importedOrganic: return "PRODUCT_CATEGORY_IMPORTED_ORGANIC"
            case .importedConventional: return "PRODUCT_CATEGORY_IMPORTED_CONVENTIONAL"
        }
    }
}
