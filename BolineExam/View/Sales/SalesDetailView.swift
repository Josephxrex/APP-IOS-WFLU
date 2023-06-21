import SwiftUI

struct SalesDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditSaleSheet = false
    
    var sale: SalesB
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Component_Button(buttonTitle: "Edit", action: action).frame(minHeight: 10, idealHeight: 10)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Fondo")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Component_Title(titleText: sale.name)
                    Component_Subtitle(subtitleText: "Data")
                    
                    Form {
                        Section(header: Text("ID:" + (sale.id ?? ""))) {
                            Component_DetailField(textTitle: "Name:", textValue: sale.name)
                            Component_DetailField(textTitle: "Quantity:", textValue: sale.quantity)
                            Component_DetailField(textTitle: "Sale ID:", textValue: sale.idv)
                            Component_DetailField(textTitle: "Purchase ID:", textValue: sale.idc)
                            Component_DetailField(textTitle: "Subtotal:", textValue: sale.subtotal)
                            Component_DetailField(textTitle: "Total:", textValue: sale.total)
                        }
                        .listRowBackground(Color("FondoList"))
                        .foregroundColor(.white)
                        
                        editButton{
                            self.presentEditSaleSheet.toggle()
                        }
                    }
                    .background(Color("Fondo"))
                    .scrollContentBackground(.hidden)
                    .onAppear() {
                        print("SalesDetailView.onAppear() for \(self.sale.name)")
                    }
                    .onDisappear() {
                        print("SalesDetailView.onDisappear()")
                    }
                }
            }
            .sheet(isPresented: self.$presentEditSaleSheet) {
                SalesEditView(viewModel: SalesViewModels(sale: sale), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    struct SalesDetailView_Previews: PreviewProvider {
        static var previews: some View {
            let sale = SalesB(name: "", quantity: "", idv: "", idc: "", subtotal: "", total: "")
            return
                NavigationView {
                    SalesDetailView(sale: sale)
                }
                .foregroundColor(.white)
                .accentColor(.white)
        }
    }
}
