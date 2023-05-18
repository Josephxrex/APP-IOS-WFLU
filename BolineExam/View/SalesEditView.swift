import SwiftUI
 
enum ModeSale {
  case new
  case edit
}
 
enum ActionSale {
  case delete
  case done
  case cancel
}
 
struct SalesEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = SalesViewModels()
    var mode: ModeSale = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save")
      }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
        Form {
          Section(header: Text("Sale Data")) {
            TextField("Name", text: $viewModel.sale.name)
            TextField("Quantity", text: $viewModel.sale.quantity)
            TextField("IDVenta", text: $viewModel.sale.idVenta)
              TextField("DCompra", text: $viewModel.sale.idCompra)
            TextField("Pieces", text: $viewModel.sale.pieces)
            TextField("Subtotal", text: $viewModel.sale.subTotal)
              TextField("Total", text: $viewModel.sale.total)
          }
           
          if mode == .edit {
            Section {
              Button("Delete Sale") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
            }
          }
        }
        .navigationTitle(mode == .new ? "New Sale" : viewModel.sale.name)
        .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
        .navigationBarItems(
          leading: cancelButton,
          trailing: saveButton
        )
        .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete Sale"),
                                     action: { self.handleDeleteTapped() }),
                        .cancel()
                      ])
        }
      }
    }
     
    // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
      self.viewModel.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
      viewModel.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
  }
 
//struct MovieEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieEditView()
//    }
//}
 
struct SalesEditView_Previews: PreviewProvider {
  static var previews: some View {
      let sale = SalesB(name: "", quantity: "", idVenta: "", idCompra: "", pieces: "", subTotal: "", total: "")
    let saleViewModel = SalesViewModels(sale: sale)
    return SalesEditView(viewModel: saleViewModel, mode: .edit)
  }
}
