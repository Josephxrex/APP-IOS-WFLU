import SwiftUI
 
struct PurchaseDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditPurchaseSheet = false
    
    var purchase: PurchaseB
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Component_Button(buttonTitle: "Edit", action: action).frame(minHeight: 10, idealHeight: 10)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Fondo")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Component_Title(titleText: purchase.name)
                    Component_Subtitle(subtitleText: "Data")
                    
                    Form {
                        Section(header: Text("ID:" + (purchase.id ?? ""))) {
                            Component_DetailField(textTitle: "IDa:", textValue: purchase.ida)
                            Component_DetailField(textTitle: "Name:", textValue: purchase.name)
                            Component_DetailField(textTitle: "Pieces:", textValue: purchase.pieces)
                        }
                        .listRowBackground(Color("FondoList"))
                        .foregroundColor(.white)
                        
                        editButton{
                            self.presentEditPurchaseSheet.toggle()
                        }
                    }.background(Color("Fondo"))
                        .scrollContentBackground(.hidden)
                        .onAppear() {
                            print("ProductsDetailView.onAppear() for \(self.purchase.name)")
                        }
                        .onDisappear() {
                            print("ProductsDetailView.onDisappear()")
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
        }
    }
    
    struct PurchaseDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            let purchase = PurchaseB(name: "EXAMPLE", ida: "EXAMPLE", pieces: "EXAMPLE")
            return
            NavigationView {
                PurchaseDetailsView(purchase: purchase)
            }.foregroundColor(.white).accentColor(.white)
        }
    }
}
