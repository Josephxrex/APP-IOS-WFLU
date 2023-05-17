import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var units:String
    var cost:String
    var price:String
    var utility:String

    enum CodingKeysB: String, CodingKey {
        case id
        case name
        case description
        case units
        case cost
        case price
        case utility
    }
}
