import SwiftUI
import Combine
 
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
    
    // Variables Products Dropdown
    @State private var isExpanded = false
    @State private var selectedItem = "Products"
    @State private var quantity = ""
    @State private var allGood = false
    
    @StateObject var productsViewModel = ProductsViewModel()
    
    // Variables Alert
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
        Button(action: { self.validateSalesFields() }) {
        Text(mode == .new ? "Done" : "Save").foregroundColor(Color("Inputs"))
      }
      .alert(isPresented: $showAlert){
          Alert(title: Text(title), message: Text(message))
          }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
        Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
        VStack {
          Section(header: Text("Sale Data").font(.largeTitle)) {
              
              
              //Component_Dropdown()
              
              DisclosureGroup("\(selectedItem)", isExpanded: $isExpanded){
                  VStack{
                      ForEach(productsViewModel.products){
                          item in
                          Text("\(item.name)")
                              .padding(.all)
                              .onTapGesture(){
                                  self.selectedItem = item.name
                                  self.quantity = item.units
                                  self.viewModel.sale.name = self.selectedItem
                                  withAnimation{
                                      self.isExpanded.toggle()
                                  }
                                  
                              }
                      }
                  }
              }.accentColor(.white)
                  .foregroundColor(.white)
                  .padding(.all)
                  .background(Color("Inputs"))
                  .cornerRadius(5.0)
                  .padding(.horizontal)
                  .onAppear() {
                     productsViewModel.subscribe()
                 }

            TextField("Quantity", text: $viewModel.sale.quantity).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
                  .keyboardType(.numberPad)
                  .onChange(of: viewModel.sale.quantity){ newValue in
                      intNull(valor: newValue)
                  }
                  .onReceive(Just(viewModel.sale.idv)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.idv = "\(filtered)"
                  }
                  }
              
              Text("Quantity Available: \(quantity)")
              
              TextField("Pieces", text: $viewModel.sale.pieces).padding()
                    .background(Color("Inputs"))
                    .foregroundColor(.white)
                    .cornerRadius(5.0)
                    .padding(.horizontal)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.sale.pieces)){
                    value in
                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                    if filtered != value {
                        self.viewModel.sale.pieces = "\(filtered)"
                    }
                    }
              
            TextField("IDVenta", text: $viewModel.sale.idv).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
                  .keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.idv)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.idv = "\(filtered)"
                  }
                  }
              
              TextField("IDCompra", text: $viewModel.sale.idc).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
                  .keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.idc)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.idc = "\(filtered)"
                  }
                  }
              
            
              
            TextField("Subtotal", text: $viewModel.sale.subtotal).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
                  .keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.subtotal)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.subtotal = "\(filtered)"
                  }
                  }
              
             TextField("Total", text: $viewModel.sale.total).padding()
                  .background(Color("Inputs"))
                  .foregroundColor(.white)
                  .cornerRadius(5.0)
                  .padding(.horizontal)
                  .keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.total)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.total = "\(filtered)"
                  }
                  }
              
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
      }.foregroundColor(.white).accentColor(.white)
    }
    
    
     
    // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
        if(allGood) {
            self.viewModel.handleDoneTapped()
            self.dismiss()
        }
    }
     
    func handleDeleteTapped() {
      viewModel.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
    
    
    // Validation functions
    func compareQuantity(valor: Int){
        if(Int(quantity)! < valor) {
            print("todo mal")
        } else{
            self.allGood = true
        }
    }
    
    func intNull(valor: String){
        if(valor != ""){
            compareQuantity(valor: Int(valor)!)
        }
    }
    
    func validateSalesFields(){
        if([viewModel.sale.name, viewModel.sale.quantity, viewModel.sale.idv, viewModel.sale.idc, viewModel.sale.pieces, viewModel.sale.subtotal, viewModel.sale.total].contains("")){
            title = "Error"
            message = "One or more fields are empty"
            showAlert.toggle()
        }else{
            title="Success"
            message="The fields were saved succesfully"
            showAlert.toggle()
            self.handleDoneTapped()
        }
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
