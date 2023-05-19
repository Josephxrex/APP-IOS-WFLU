import SwiftUI



struct SalesListView: View {
    
    //Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddSaleSheet = false
    
    @StateObject var saleViewModel = SalesViewModel()
    //Funciones
    private func addButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("+").font(.largeTitle)
        }
    }
    
    //Cuerpo
    var body: some View {
        NavigationView{
            List{
                ForEach(saleViewModel.sales) {
                    sale in NavigationLink(destination: SalesDetailView(sale: sale)){
                        SaleRowView(sale:sale)
                    }
                }
                .onDelete(){
                    indexSet in saleViewModel.removeSales(atOffsets: indexSet)
                }
                .foregroundColor(Color.mint)
            }.navigationTitle("Sales")
                .navigationBarItems(trailing: addButton {
                    self.presentAddSaleSheet.toggle()
            })
            .onAppear(){
                    saleViewModel.subscribe()
                }
            .sheet(isPresented: self.$presentAddSaleSheet){
                let sale = SalesB(name: "", quantity: "", idv: "", idc: "", pieces: "", subtotal: "", total: "")
                SalesEditView(viewModel: SalesViewModels(sale: sale), mode: .new) { result in
                    if case .success(let action) = result, action == .delete {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct SalesListView_Previews: PreviewProvider {
    static var previews: some View {
        SalesListView()
    }
}
