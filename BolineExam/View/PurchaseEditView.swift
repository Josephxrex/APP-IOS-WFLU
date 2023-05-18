import SwiftUI
import Combine

enum ModePurchase {
  case new
  case edit
}
 
enum ActionPurchase {
  case delete
  case done
  case cancel
}

struct PurchaseEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentActionSheet = false
    @ObservedObject var viewModel = PurchaseViewModel()
    var mode: ModePurchase = .new
    var completionHandler: ((Result<ActionPurchase, Error>) -> Void)?

    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Purchases").font(.largeTitle).padding()
                
                Component_TextField(textFieldTitle: "Name", textFieldText: $viewModel.purchase.name)
                    //Unidades
                Component_TextField(textFieldTitle: "Units", textFieldText: $viewModel.purchase.pieces)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.purchase.pieces)){
                    value in
                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                    if filtered != value {
                        self.viewModel.purchase.pieces = "\(filtered)"
                    }
                    };

                
                Button("Done") {
                    validateFields()
                }.padding()
                    .alert(isPresented: $showAlert){
                    Alert(title: Text(title), message: Text(message))
                    }

                

                if mode == .edit {
                 Section {
                  Button("Delete Purchase") { self.presentActionSheet.toggle() }
                    .foregroundColor(.red)
                 }
                }
                
                
            }
        }
    }
    
    //Validar campos
    func validateFields(){
        if([viewModel.purchase.name, viewModel.purchase.pieces].contains("")){
            title = "Error"
            message = "One or more fields are empty"
            showAlert = true
        }else{
            self.handleDoneTapped()
            clean()
            title="Success"
            message="The fields were saved succesfully"
            showAlert = true
        }
    }
    
    func clean(){
        viewModel.purchase.name=""
        viewModel.purchase.idP=""
        viewModel.purchase.pieces=""
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
