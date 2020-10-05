import Foundation

struct Category: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var indicators: [Int]
}
