import Foundation
import FirebaseFirestoreSwift

struct ProductB: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var units:String
    var cost:String
    var utility:String
    var price:String
   

    enum CodingKeysProductB: String, CodingKey {
        case id
        case name
        case description
        case units
        case cost
        case price
        case utility
    }
}
