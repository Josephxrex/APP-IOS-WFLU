import SwiftUI



struct SalesListView: View {
    
    //Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddSaleSheet = false
    
    @StateObject var saleViewModel = SalesViewModel()
    
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
                    
                    List{
                        ForEach(saleViewModel.sales) {
                            sale in NavigationLink(destination: SalesDetailView(sale: sale)){
                                SaleRowView(sale:sale)
                            }.listRowBackground(Color("FondoList"))
                        }
                        .onDelete(){
                            indexSet in saleViewModel.removeSales(atOffsets: indexSet)
                        }
                    }.background(Color("Fondo")).scrollContentBackground(.hidden)
                        .onAppear(){
                            saleViewModel.subscribe()
                        }
                        .sheet(isPresented: self.$presentAddSaleSheet){
                            let sale = SalesB(name: "", quantity: "", idv: "", idc: "", subtotal: "", total: "")
                            SalesEditView(viewModel: SalesViewModels(sale: sale), mode: .new) { result in
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
                    Component_Title(titleText: "Sales")
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        addButton {
                            presentAddSaleSheet.toggle()
                        }
                    }
                    .padding(.trailing, 35)
                    .padding(.bottom, 35)
                }
            }
        
    }
    
    struct SalesListView_Previews: PreviewProvider {
        static var previews: some View {
            SalesListView()
        }
    }
}
