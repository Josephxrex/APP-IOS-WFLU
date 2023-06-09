import SwiftUI
import Combine

enum ModeProducts {
  case new
  case edit
}
 
enum ActionProducts {
  case delete
  case done
}

struct ProductsEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentActionSheet = false
    @ObservedObject var viewModelProducts = ProductViewModel()
    
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    //Variables para guardar los valores
    @State private var name = "";
    @State private var units = "";
    @State private var cost = "";
    @State private var price = "";
    @State private var utility = "";
    @State private var description = "";
    
    
    var mode: ModeProducts = .new
    var completionHandler: ((Result<ActionProducts, Error>) -> Void)?
     
    var saveButton: some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: validateFields).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
    }
    
    var body: some View {
        NavigationView{
           Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
                VStack{
                    Section(header: Component_Title(titleText: mode == .new ? "New product" : "Edit product")) {
                        if(mode == .edit) {
                            //Vista en caso de actualización de registro
                            Component_TextField(textFieldTitle: "Name", textFieldText: $viewModelProducts.product.name).onAppear(){
                                name = viewModelProducts.product.name
                            }.onChange(of: viewModelProducts.product.name){
                                newValue in
                                name = newValue
                            }
                                
                            Component_TextField(textFieldTitle: "Description", textFieldText: $viewModelProducts.product.description).onAppear(){
                                description = viewModelProducts.product.description
                            }.onChange(of: viewModelProducts.product.description){
                                newValue in
                                description = newValue
                            }
                                
                            Component_TextField(textFieldTitle: "Units", textFieldText: $viewModelProducts.product.units)
                                .onReceive(Just(viewModelProducts.product.units)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.viewModelProducts.product.units = "\(filtered)"
                                }
                                }.onAppear(){
                                    units = viewModelProducts.product.units
                                }.onChange(of: viewModelProducts.product.units){
                                    newValue in
                                    units = newValue
                                }
                            
                            Component_TextField(textFieldTitle: "Cost", textFieldText: $viewModelProducts.product.cost)
                                .onReceive(Just(viewModelProducts.product.cost)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.viewModelProducts.product.cost = "\(filtered)"
                                }
                                }.onAppear(){
                                    cost = viewModelProducts.product.cost
                                }.onChange(of: viewModelProducts.product.cost){
                                    newValue in
                                    cost = newValue
                                }
                            
                                Component_TextField(textFieldTitle: "Price", textFieldText: $viewModelProducts.product.price)
                                .onReceive(Just(viewModelProducts.product.price)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.viewModelProducts.product.price = "\(filtered)"
                                }
                                }.onAppear(){
                                    price = viewModelProducts.product.price
                                }.onChange(of: viewModelProducts.product.price){
                                    newValue in
                                    price = newValue
                                }
                            
                                Component_TextField(textFieldTitle: "Utility", textFieldText: $viewModelProducts.product.utility)
                                .onReceive(Just(viewModelProducts.product.utility)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.viewModelProducts.product.utility = "\(filtered)"
                                }
                                }.onAppear(){
                                    utility = viewModelProducts.product.utility
                                }.onChange(of: viewModelProducts.product.utility){
                                    newValue in
                                    utility = newValue
                                }
                                
                                Spacer().frame(height: 50)
                                
                                saveButton
                            
                        }else
                        {
                            //Vista en caso de nuevo registro
                            Component_TextField(textFieldTitle: "Name", textFieldText: $name).onChange(of: name){
                                newValue in
                                viewModelProducts.product.name = newValue
                                name = newValue
                            }
                                
                            Component_TextField(textFieldTitle: "Description", textFieldText: $description).onChange(of: description){
                                newValue in
                                viewModelProducts.product.description = newValue
                                description = newValue
                            }
                                
                            Component_TextField(textFieldTitle: "Units", textFieldText: $units)
                                .onReceive(Just(units)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.units = "\(filtered)"
                                }
                                }.onChange(of: units){
                                    newValue in
                                    viewModelProducts.product.units = newValue
                                    units = newValue
                                }
                            
                            Component_TextField(textFieldTitle: "Cost", textFieldText: $cost)
                                .onReceive(Just(cost)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.cost = "\(filtered)"
                                }
                                }.onChange(of: cost){
                                    newValue in
                                    viewModelProducts.product.cost = newValue
                                    cost = newValue
                                }
                            
                                Component_TextField(textFieldTitle: "Price", textFieldText: $price)
                                .onReceive(Just(price)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.price = "\(filtered)"
                                }
                                }.onChange(of: price){
                                    newValue in
                                    viewModelProducts.product.price = newValue
                                    price = newValue
                                }
                            
                                Component_TextField(textFieldTitle: "Utility", textFieldText: $utility)
                                .onReceive(Just(viewModelProducts.product.utility)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.utility = "\(filtered)"
                                }
                                }.onChange(of: utility){
                                    newValue in
                                    viewModelProducts.product.utility = newValue
                                    utility = newValue
                                }
                                
                                Spacer().frame(height: 50)
                                
                                saveButton                        }
                        
                    
            }//Fin de section
        }//Fin de vstack
            )//Cierre de Overlay
            .foregroundColor(.white)
    }.foregroundColor(.white).accentColor(.white)//Fin de NavigationView
}//Fin de view
    
    // Validation 
    func validateFields(){
        print(name + " " + units + " " + cost + " " + price + " " + utility)
        if([name, units, cost, price, utility].contains("")){
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
      self.viewModelProducts.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
        viewModelProducts.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        ProductsEditView()
    }
}
