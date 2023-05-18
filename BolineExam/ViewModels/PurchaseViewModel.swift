import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class PurchaseViewModel: ObservableObject {
    
    @Published var purchase: PurchaseB
    @Published var modified = false
     
    private var cancellables = Set<AnyCancellable>()
    
    //FIRESTORE
    private let db = Firestore.firestore()
    private let collection = "purchase" // Nombre de la colección en la base de datos
    
    init(purchase: PurchaseB = PurchaseB(name: "", ida: "", pieces: "")) {
        self.purchase = purchase
        
        self.$purchase
            .dropFirst()
            .sink{[weak self] purchase in self?.modified = true}.store(in: &self.cancellables)
    }
    
    func addPurchase(_ purchase: PurchaseB) {
        do {
            _ = try db.collection(collection).addDocument(from: purchase)
        } catch {
            print("Error adding document: \(error.localizedDescription)")
        }
    }
    
    func updatePurchase(_ purchase: PurchaseB) {
        if let purchaseID = purchase.id {
            do {
                try db.collection(collection).document(purchaseID).setData(from: purchase)
            } catch {
                print("Error updating document: \(error.localizedDescription)")
            }
        }
    }
    
    func updateOrAddPurchase() {
        if let _ = purchase.id {
            self.updatePurchase(self.purchase)
        }else{
            addPurchase(purchase)
        }
    }
    
    func deletePurchase() {
        if let purchaseID = purchase.id {
            db.collection(collection).document(purchaseID).delete { error in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }
    // UI handlers
     
    func handleDoneTapped() {
        self.updateOrAddPurchase()
    }
     
    func handleDeleteTapped() {
      self.deletePurchase()
    }
}


