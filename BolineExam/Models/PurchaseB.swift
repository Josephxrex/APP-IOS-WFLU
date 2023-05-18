import Foundation
import FirebaseFirestoreSwift

struct PurchaseB: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var idP:String
    var pieces: String
    

    enum CodingKeysPurchaseB: String, CodingKey {
        case id
        case name
        case idP
        case pieces
    }
}
