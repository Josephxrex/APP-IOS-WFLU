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
        Text(mode == .new ? "Done" : "Save").foregroundColor(Color("Inputs"))
      }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
        Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
        VStack {
          Section(header: Text("Sale Data").font(.largeTitle)) {
            TextField("Name", text: $viewModel.sale.name).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
              
            TextField("Quantity", text: $viewModel.sale.quantity).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
              
            TextField("IDVenta", text: $viewModel.sale.idv).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
              
              TextField("DCompra", text: $viewModel.sale.idc).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
              
            TextField("Pieces", text: $viewModel.sale.pieces).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
              
            TextField("Subtotal", text: $viewModel.sale.subtotal).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
              
             TextField("Total", text: $viewModel.sale.total).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
              
          }
           
          if mode == .edit {
            Section {
              Button("Delete Sale") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
                .font(.headline)
                .padding()
            }
          }
        }//Fin de Vstack
        )//Cierre de Overlay
        .foregroundColor(.white)
        .navigationTitle(mode == .new ? "New Sale" : "Edit:"+viewModel.sale.name).foregroundColor(.white)
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
      let sale = SalesB(name: "", quantity: "", idv: "", idc: "", pieces: "", subtotal: "", total: "")
    let saleViewModel = SalesViewModels(sale: sale)
    return SalesEditView(viewModel: saleViewModel, mode: .edit)
  }
}
