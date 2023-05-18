import Foundation
import FirebaseFirestoreSwift

struct PurchaseB: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var ida:String
    var pieces: String
    

    enum CodingKeysPurchaseB: String, CodingKey {
        case id
        case name
        case ida
        case pieces
    }
}
