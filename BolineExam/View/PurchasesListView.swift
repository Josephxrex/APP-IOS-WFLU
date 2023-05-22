import SwiftUI

struct PurchasesListView: View {
    //Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddPurchaseSheet = false
    
    @StateObject var purchaseViewModel = PurchaseViewModels()
    
    //Funciones
    private func addButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("+").font(.largeTitle).foregroundColor(Color("FondoList"))
        }
    }
    
    
    var body: some View {
        NavigationView{
            List {
                ForEach(purchaseViewModel.purchases) { purchase in
                    NavigationLink(destination: PurchaseDetailsView(purchase: purchase)) {
                        PurchaseRowView(purchase: purchase)
                    }.listRowBackground(Color("FondoList"))
                }
                .onDelete(){
                    indexSet in
                    purchaseViewModel.removePurchases(atOffsets: indexSet)
                }
            }.background(Color("Fondo")).scrollContentBackground(.hidden)
            
             .onAppear() {
                 purchaseViewModel.subscribe()
            }
             .sheet(isPresented: self.$presentAddPurchaseSheet){
                 let purchase = PurchaseB(name: "", ida: "", pieces: "")
                 PurchaseEditView(viewModel: PurchaseViewModel(purchase: purchase), mode: .new) { result in
                     if case .success(let action) = result, action == .delete {
                         self.presentationMode.wrappedValue.dismiss()
                     }
                 }
             }
        }.navigationBarTitle("Purchases")
            .navigationBarItems(trailing: addButton {
                self.presentAddPurchaseSheet.toggle()
        }).foregroundColor(.white).accentColor(.white)
        
    }
}

struct PurchasesListView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasesListView()
    }
}
