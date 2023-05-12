import Foundation
import FirebaseFirestoreSwift

struct Purchase: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var ida:String
    var pieces: String
    

    enum CodingKeysPurchase: String, CodingKey {
        case id
        case pieces
        case ida
    }
}
