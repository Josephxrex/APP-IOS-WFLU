import Combine
import FirebaseFirestore
 
class PurchaseViewModels: ObservableObject {
  @Published var purchases = [PurchaseB]()
   
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
      listenerRegistration = db.collection("purchase").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.purchases = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: PurchaseB.self)
        }
      }
    }
  }
    
   
  func removePurchases(atOffsets indexSet: IndexSet) {
    let purchases = indexSet.lazy.map { self.purchases[$0] }
      purchases.forEach { purchase in
      if let documentId = purchase.id {
        db.collection("purchase").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
