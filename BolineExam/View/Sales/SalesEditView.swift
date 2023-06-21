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
    @State private var units = ""
    @State private var allGood = false
    
    // Variables para guardar los valores de los
    @State private var name = ""
    @State private var quantity = ""
    @State private var saleid = ""
    @State private var purchaseid = ""
    @State private var subtotal = ""
    @State private var total = ""
    
    var mode: ModeSale = .new
    var completionHandler: ((Result<ActionSale, Error>) -> Void)?
    
    var saveButton:  some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: validateFields).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
    }
     
    var body: some View {
      NavigationView {
        Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
        VStack {
          Section(header: Component_Title(titleText: mode == .new ? "New sale" : "Edit sale")) {
              if(mode == .edit){
                  //Component_Dropdown()
                  DisclosureGroup("\(viewModel.sale.name)", isExpanded: $isExpanded){
                      VStack{
                          ForEach(productsViewModel.products){
                              item in
                              Text("\(item.name)")
                                  .padding(.all)
                                  .onTapGesture(){
                                      self.selectedItem = item.name
                                      self.units = item.units
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
                          name = viewModel.sale.name
                     }
                      .onChange(of: viewModel.sale.name){newValue in name = newValue
                          viewModel.sale.name = newValue
                      }

                  Component_TextField(textFieldTitle: "Quantity", textFieldText: $quantity).keyboardType(.numberPad)
                      .onAppear(){quantity = viewModel.sale.quantity}
                      .onChange(of: quantity){ newValue in
                          quantity = newValue
                          viewModel.sale.quantity = newValue
                          print("Old value " + units)
                          print("New value " + newValue)
                          intNull(valor: newValue)
                          
                      }
                      .onReceive(Just(quantity)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.quantity = "\(filtered)"
                      }
                      }
                  
                  Text("Quantity Available: \(units)")
                  
                  
                  Component_TextField(textFieldTitle: "Sale ID", textFieldText: $saleid).keyboardType(.numberPad)
                      .onAppear(){saleid = viewModel.sale.idv}
                      .onChange(of: saleid){newValue in saleid = newValue
                          viewModel.sale.idv = newValue
                      }
                      .onReceive(Just(saleid)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.saleid = "\(filtered)"
                      }
                      }
                  
                  Component_TextField(textFieldTitle: "Purchase ID", textFieldText: $purchaseid).keyboardType(.numberPad)
                      .onAppear(){purchaseid = viewModel.sale.idc}
                      .onChange(of: purchaseid){newValue in purchaseid = newValue
                          viewModel.sale.idc = newValue
                      }
                      .onReceive(Just(purchaseid)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.purchaseid = "\(filtered)"
                      }
                      }
                  
                  Component_TextField(textFieldTitle: "Subtotal", textFieldText: $subtotal).keyboardType(.numberPad)
                      .onAppear(){subtotal = viewModel.sale.subtotal}
                      .onChange(of: subtotal){newValue in subtotal = newValue
                          viewModel.sale.subtotal = newValue
                      }
                      .onReceive(Just(subtotal)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.subtotal = "\(filtered)"
                      }
                      }
                  
                  Component_TextField(textFieldTitle: "Total", textFieldText: $total).keyboardType(.numberPad)
                      .onAppear(){total = viewModel.sale.total}
                      .onChange(of: total){newValue in total = newValue
                          viewModel.sale.total = newValue
                      }
                      .onReceive(Just(total)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.total = "\(filtered)"
                      }
                      }
                  Spacer().frame(height: 50)
                  
                  saveButton

              } else{
                  //Component_Dropdown()
                  DisclosureGroup("\(selectedItem)", isExpanded: $isExpanded){
                      VStack{
                          ForEach(productsViewModel.products){
                              item in
                              Text("\(item.name)")
                                  .padding(.all)
                                  .onTapGesture(){
                                      self.selectedItem = item.name
                                      self.units = item.units
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
                      .onChange(of: viewModel.sale.name){newValue in name = newValue
                          viewModel.sale.name = newValue
                      }

                  Component_TextField(textFieldTitle: "Quantity", textFieldText: $quantity).keyboardType(.numberPad)
                      .onChange(of: quantity){ newValue in
                          quantity = newValue
                          viewModel.sale.quantity = newValue
                          print("Old value " + units)
                          print("New value " + newValue)
                          intNull(valor: newValue)
                          
                      }
                      .onReceive(Just(quantity)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.quantity = "\(filtered)"
                      }
                      }
                  
                  Text("Quantity Available: \(units)")
                  
                  Component_TextField(textFieldTitle: "Sale ID", textFieldText: $saleid).keyboardType(.numberPad)
                      .onChange(of: saleid){newValue in saleid = newValue
                          viewModel.sale.idv = newValue
                      }
                      .onReceive(Just(saleid)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.saleid = "\(filtered)"
                      }
                      }
                  
                  Component_TextField(textFieldTitle: "Purchase ID", textFieldText: $purchaseid).keyboardType(.numberPad)
                      .onChange(of: purchaseid){newValue in purchaseid = newValue
                          viewModel.sale.idc = newValue
                      }
                      .onReceive(Just(purchaseid)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.purchaseid = "\(filtered)"
                      }
                      }
                  
                  Component_TextField(textFieldTitle: "Subtotal", textFieldText: $subtotal).keyboardType(.numberPad)
                      .onChange(of: subtotal){newValue in subtotal = newValue
                          viewModel.sale.subtotal = newValue
                      }
                      .onReceive(Just(subtotal)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.subtotal = "\(filtered)"
                      }
                      }
                  
                  Component_TextField(textFieldTitle: "Total", textFieldText: $total).keyboardType(.numberPad)
                      .onChange(of: total){newValue in total = newValue
                          viewModel.sale.total = newValue
                      }
                      .onReceive(Just(total)){
                      value in
                      let filtered = "\(value)".filter { "0123456789".contains($0) }
                      if filtered != value {
                          self.total = "\(filtered)"
                      }
                      }
                  Spacer().frame(height: 50)
                  
                  saveButton
              }
              
          }
        }//Fin de Vstack
        )//Cierre de Overlay
        .foregroundColor(.white)
      }.foregroundColor(.white).accentColor(.white)
    }
    
    // Validation
    func validateFields(){
        print( total + " " +  subtotal + " " + purchaseid + " " + quantity + " " + saleid)
        if([name, total,  subtotal, purchaseid, quantity, saleid].contains("")){
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
      let sale = SalesB(name: "", quantity: "", idv: "", idc: "", subtotal: "", total: "")
    let saleViewModel = SalesViewModels(sale: sale)
    return SalesEditView(viewModel: saleViewModel, mode: .edit)
  }
}
