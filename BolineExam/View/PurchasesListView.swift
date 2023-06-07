import SwiftUI

struct PurchasesListView: View {
    //Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddPurchaseSheet = false
    
    @StateObject var purchaseViewModel = PurchaseViewModels()
    
    // Funciones
    private func addButton(action: @escaping () -> Void) -> some View {
        Component_AddButton(action: action)
    }
    
    var body: some View {
            ZStack {
                Color("Fondo")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 200)
                    
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
                }.foregroundColor(.white).accentColor(.white)
                    .navigationBarTitleDisplayMode(.inline)
                
                VStack {
                    Spacer().frame(height: 110)
                    
                    Component_Subtitle(subtitleText: "List of")
                    Component_Title(titleText: "Purchases")
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        addButton {
                            presentAddPurchaseSheet.toggle()
                        }
                    }
                    .padding(.trailing, 35)
                    .padding(.bottom, 35)
                }
            }
        
    }
    struct PurchasesListView_Previews: PreviewProvider {
        static var previews: some View {
            PurchasesListView()
        }
    }
}
