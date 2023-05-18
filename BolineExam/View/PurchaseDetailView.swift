import SwiftUI
 
struct PurchaseDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditPurchaseSheet = false
     
    var purchase: PurchaseB
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
      Form {
        Section(header: Text("Purchase")) {
            Text(purchase.ida)
            Text(purchase.name)
            Text(purchase.pieces)
             
        }
      }
      .navigationBarTitle("Purchase: " + purchase.name)
      .navigationBarItems(trailing: editButton {
        self.presentEditPurchaseSheet.toggle()
      })
      .onAppear() {
        print("PurchaseDetailView.onAppear() for \(self.purchase.name)")
      }
      .onDisappear() {
        print("PurchaseDetailView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditPurchaseSheet) {
        PurchaseEditView(viewModel: PurchaseViewModel(purchase: purchase), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
     
  }
 
struct PurchaseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let purchase = PurchaseB(name: "", ida: "", pieces: "")
        return
          NavigationView {
            PurchaseDetailsView(purchase: purchase)
          }
    }
}
