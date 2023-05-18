import SwiftUI

struct SalesDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
    
    var sale: SalesB
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
        }
    }
    
    //CUERPO
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Sale")) {
                    Text(sale.name)
                    Text(sale.quantity)
                    Text(sale.idVenta)
                    Text(sale.idCompra)
                    Text(sale.pieces)
                    Text(sale.pieces)
                    Text(sale.subTotal)
                    Text(sale.total)
                }
            }
            .navigationBarTitle(sale.name)
            .navigationBarItems(trailing: editButton {
                self.presentEditMovieSheet.toggle()
            })
            .onAppear() {
                print("UserDetailsView.onAppear() for \(self.sale.name)")
            }
            .onDisappear() {
                print("UserDetailsView.onDisappear()")
            }
            .sheet(isPresented: self.$presentEditMovieSheet) {
                SalesEditView(viewModel: SalesViewModels(sale: sale), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    struct MovieDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            let sale = SalesB(name: "", quantity: "", idVenta: "", idCompra: "", pieces: "", subTotal: "", total: "")
            return
                NavigationView {
                    SalesDetailView(sale: sale)
                }
            }
        }
}
