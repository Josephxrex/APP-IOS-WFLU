import SwiftUI
import Combine
 
enum ModeSale {
  case new
  case edit
}
 
enum ActionSale {
  case delete
  case done
}
 
struct SalesEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @ObservedObject var viewModel = SalesViewModels()
    @StateObject var productsViewModel = ProductsViewModel()
    
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    // Variables Products Dropdown
    @State private var isExpanded = false
    @State private var selectedItem = "Products"
    @State private var quantity = ""
    @State private var allGood = false
    
    var mode: ModeSale = .new
    var completionHandler: ((Result<ActionSale, Error>) -> Void)?
    
    private func saveButton(action: @escaping () -> Void) -> some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: action).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
            .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
        Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
        VStack {
          Section(header: Component_Title(titleText: mode == .new ? "New sale" : "Edit sale")) {
              

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
                                  print(quantity)
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

              Component_TextField(textFieldTitle: "Quantity", textFieldText: $viewModel.sale.quantity).keyboardType(.numberPad)
                  .onChange(of: quantity){ newValue in
                      print("Old value " + quantity)
                      print("New value " + newValue)
                      intNull(valor: newValue)
                      
                  }
                  .onReceive(Just(viewModel.sale.quantity)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.quantity = "\(filtered)"
                  }
                  }
              
              Text("Quantity Available: \(quantity)")
              
              Component_TextField(textFieldTitle: "Pieces", textFieldText: $viewModel.sale.pieces).keyboardType(.numberPad)
                    .onReceive(Just(viewModel.sale.pieces)){
                    value in
                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                    if filtered != value {
                        self.viewModel.sale.pieces = "\(filtered)"
                    }
                    }
              
              Component_TextField(textFieldTitle: "Sale ID", textFieldText: $viewModel.sale.idv).keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.idv)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.idv = "\(filtered)"
                  }
                  }
              
              Component_TextField(textFieldTitle: "Purchase ID", textFieldText: $viewModel.sale.idc).keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.idc)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.idc = "\(filtered)"
                  }
                  }
              
              Component_TextField(textFieldTitle: "Subtotal", textFieldText: $viewModel.sale.subtotal).keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.subtotal)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.subtotal = "\(filtered)"
                  }
                  }
              
              Component_TextField(textFieldTitle: "Total", textFieldText: $viewModel.sale.total).keyboardType(.numberPad)
                  .onReceive(Just(viewModel.sale.total)){
                  value in
                  let filtered = "\(value)".filter { "0123456789".contains($0) }
                  if filtered != value {
                      self.viewModel.sale.total = "\(filtered)"
                  }
                  }
              Spacer().frame(height: 50)
              
              saveButton(action: validateFields)
              
          }
        }//Fin de Vstack
        )//Cierre de Overlay
        .foregroundColor(.white)
      }.foregroundColor(.white).accentColor(.white)
    }
    
    // Validation
    func validateFields(){
        print(viewModel.sale.pieces + " " + viewModel.sale.total + " " +  viewModel.sale.subtotal + " " + viewModel.sale.idc + " " + viewModel.sale.quantity + " " + viewModel.sale.idv)
        if([viewModel.sale.pieces, viewModel.sale.total, viewModel.sale.subtotal, viewModel.sale.idc, viewModel.sale.quantity, viewModel.sale.idv].contains("")){
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
