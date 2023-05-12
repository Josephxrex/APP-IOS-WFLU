import Foundation
import FirebaseFirestoreSwift

struct UserB: Identifiable , Codable {
    @DocumentID var id: String?
    var name: String
    var lastname: String
    var age:String
    var gender:String
    var emial:String
    var password:String
    enum CodingKeysUser: String, CodingKey {
        case id
        case name
        case lastname
        case age
        case gender
        case email
        case password
    }
}
