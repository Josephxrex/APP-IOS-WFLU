import Foundation
import FirebaseFirestoreSwift

struct SalesB: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var quantity: String
    var idVenta:String
    var idCompra:String
    var pieces:String
    var subTotal:String
    var total:String

    enum CodingKeysSalesB: String, CodingKey {
        case id
        case name
        case quantity
        case idVenta
        case idCompra
        case pieces
        case subTotal
        case total
    }
}
