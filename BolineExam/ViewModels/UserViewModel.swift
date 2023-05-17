import Foundation
import Combine
import FirebaseFirestore
 
class UsersViewModel: ObservableObject {
  @Published var users = [UserB]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("user").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.users = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: UserB.self)
        }
      }
    }
  }
   
  func removeUsers(atOffsets indexSet: IndexSet) {
    let users = indexSet.lazy.map { self.users[$0] }
    users.forEach { user in
      if let documentId = user.id {
        db.collection("user").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}

