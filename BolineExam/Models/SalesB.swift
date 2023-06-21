import Foundation
import FirebaseFirestoreSwift

struct SalesB: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var quantity: String
    var idv:String
    var idc:String
    var subtotal:String
    var total:String

    enum CodingKeysSalesB: String, CodingKey {
        case id
        case name
        case quantity
        case idv
        case idc
        case subtotal
        case total
    }
}
