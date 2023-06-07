import SwiftUI
import Combine

enum ModePurchase {
  case new
  case edit
}
 
enum ActionPurchase {
  case delete
  case done
}

struct PurchaseEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentActionSheet = false
    @ObservedObject var viewModel = PurchaseViewModel()
    
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    var mode: ModePurchase = .new
    var completionHandler: ((Result<ActionPurchase, Error>) -> Void)?

    private func saveButton(action: @escaping () -> Void) -> some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: action).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
            .disabled(!viewModel.modified)
    }
    
    var body: some View {
        NavigationView{
            Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
            VStack {
                Section(header: Component_Title(titleText: mode == .new ? "New purchase" : "Edit purchase")) {
                    Component_TextField(textFieldTitle: "ida", textFieldText: $viewModel.purchase.ida).keyboardType(.numberPad)
                            .onReceive(Just(viewModel.purchase.pieces)){
                            value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.viewModel.purchase.pieces = "\(filtered)"
                            }
                          }
                    
                        Component_TextField(textFieldTitle: "Name", textFieldText: $viewModel.purchase.name)
                        
                    Component_TextField(textFieldTitle: "Units", textFieldText: $viewModel.purchase.pieces).keyboardType(.numberPad)
                            .onReceive(Just(viewModel.purchase.pieces)){
                            value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.viewModel.purchase.pieces = "\(filtered)"
                            }
                            }
                    
                    Spacer().frame(height: 50)
                    
                    saveButton(action: validateFields)
                }
            }//Fin de Vstack
            )//Cierre de Overlay
            .foregroundColor(.white)
        }.foregroundColor(.white).accentColor(.white)
    }//Fin de view
    
    // Validation
    func validateFields(){
        if([viewModel.purchase.name,viewModel.purchase.pieces, viewModel.purchase.ida].contains("")){
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

struct Purchase_Previewss: PreviewProvider {
    static var previews: some View {
        PurchaseEditView()
    }
}


