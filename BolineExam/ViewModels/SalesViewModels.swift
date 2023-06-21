import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class SalesViewModels: ObservableObject {
    
    @Published var sale: SalesB
    @Published var modified = false
     
    private var cancellables = Set<AnyCancellable>()
    
    //FIRESTORE
    private let db = Firestore.firestore()
    private let collection = "sale" // Nombre de la colección en la base de datos
    
    init(sale: SalesB = SalesB(name:"",quantity: "",idv: "",idc: "",subtotal: "",total: "")) {
        self.sale = sale
        
        self.$sale
            .dropFirst()
            .sink{[weak self] sale in self?.modified = true}.store(in: &self.cancellables)
    }
    
    private func addSale(_ sale: SalesB) {
        do {
            _ = try db.collection(collection).addDocument(from: sale)
        } catch {
            print("Error adding document: \(error.localizedDescription)")
        }
    }
    
    private func updateSale(_ sale: SalesB) {
        if let saleID = sale.id {
            do {
                try db.collection(collection).document(saleID).setData(from: sale)
            } catch {
                print("Error updating document: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateOrAddSale() {
        if let _ = sale.id {
            self.updateSale(self.sale)
        }else{
            addSale(sale)
        }
    }
    
    private func deleteSale() {
        if let saleID = sale.id {
            db.collection(collection).document(saleID).delete { error in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }
    // UI handlers
     
    func handleDoneTapped() {
        self.updateOrAddSale()
    }
     
    func handleDeleteTapped() {
      self.deleteSale()
    }
}
