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
    @ObservedObject var viewModel = ProductViewModel()
    
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    var mode: ModeProducts = .new
    var completionHandler: ((Result<ActionProducts, Error>) -> Void)?
     
    private func saveButton(action: @escaping () -> Void) -> some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: action).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
            .disabled(!viewModel.modified)
    }
    
    var body: some View {
        NavigationView{
           Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
                VStack{
                    Section(header: Component_Title(titleText: mode == .new ? "New product" : "Edit product")) {
                    Component_TextField(textFieldTitle: "Name", textFieldText: $viewModel.product.name)
                        
                    Component_TextField(textFieldTitle: "Description", textFieldText: $viewModel.product.description)
                        
                    Component_TextField(textFieldTitle: "Units", textFieldText: $viewModel.product.units)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.units)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.units = "\(filtered)"
                        }
                        }
                    
                    Component_TextField(textFieldTitle: "Cost", textFieldText: $viewModel.product.cost).keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.cost)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.cost = "\(filtered)"
                        }
                        }
                    
                        Component_TextField(textFieldTitle: "Price", textFieldText: $viewModel.product.price)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.price)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.price = "\(filtered)"
                        }
                        }
                    
                        Component_TextField(textFieldTitle: "Utility", textFieldText: $viewModel.product.utility).keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.utility)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.utility = "\(filtered)"
                        }
                        }
                        
                        Spacer().frame(height: 50)
                        
                        saveButton(action: validateFields)
            }//Fin de section
        }//Fin de vstack
            )//Cierre de Overlay
            .foregroundColor(.white)
    }.foregroundColor(.white).accentColor(.white)//Fin de NavigationView
}//Fin de view
    
    // Validation 
    func validateFields(){
        if([viewModel.product.name, viewModel.product.units, viewModel.product.cost, viewModel.product.price, viewModel.product.utility].contains("")){
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

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        ProductsEditView()
    }
}
