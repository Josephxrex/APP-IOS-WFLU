import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class UserViewModels: ObservableObject {
    
    @Published var user: UserB
    @Published var modified = false
     
    private var cancellables = Set<AnyCancellable>()
    
    init(user: UserB = UserB(name:"",lastname:"",age: "",gender: "",email: "",password: "")) {
        self.user = user
        
        self.$user
            .dropFirst()
            .sink{[weak self] user in self?.modified = true}.store(in: &self.cancellables)
    }
    
    //FIRESTORE
    private let db = Firestore.firestore()
    
    private let collection = "user" // Nombre de la colección en la base de datos
    
    private func addUser(_ user: UserB) {
        do {
            _ = try db.collection(collection).addDocument(from: user)
        } catch {
            print("Error adding document: \(error.localizedDescription)")
        }
    }
    
    private func updateUser(_ user: UserB) {
        if let userID = user.id {
            do {
                try db.collection(collection).document(userID).setData(from: user)
            } catch {
                print("Error updating document: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateOrAddUser() {
        if let _ = user.id {
            self.updateUser(self.user)
        }else{
            addUser(user)
        }
    }
    
    private func deleteUser() {
        if let userID = user.id {
            db.collection(collection).document(userID).delete { error in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }
    // UI handlers
     
    func handleDoneTapped() {
        self.updateOrAddUser()
    }
     
    func handleDeleteTapped() {
      self.deleteUser()
    }
}
