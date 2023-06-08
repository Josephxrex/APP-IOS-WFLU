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
    
    //Variales para guardar valores
    @State private var ida = "";
    @State private var name = "";
    @State private var pieces = "";
    
    
    var mode: ModePurchase = .new
    var completionHandler: ((Result<ActionPurchase, Error>) -> Void)?

    var saveButton: some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: validateFields).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
    }
    
    var body: some View {
        NavigationView{
            Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
            VStack {
                Section(header: Component_Title(titleText: mode == .new ? "New purchase" : "Edit purchase")) {
                    if(mode == .edit){
                        //Vista en caso de actualización de registro
                        Component_TextField(textFieldTitle: "ida", textFieldText: $viewModel.purchase.ida).keyboardType(.numberPad)
                                .onReceive(Just(ida)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.viewModel.purchase.ida = "\(filtered)"
                                }
                                }.onAppear(){ida = viewModel.purchase.ida}
                                .onChange(of: viewModel.purchase.ida){ newValue in
                                    ida = newValue
                                }
                        
                        Component_TextField(textFieldTitle: "Name", textFieldText: $viewModel.purchase.name).onAppear(){name = viewModel.purchase.name}
                            .onChange(of: viewModel.purchase.name){ newValue in
                            name = newValue
                        }
                            
                        Component_TextField(textFieldTitle: "Pieces", textFieldText: $viewModel.purchase.pieces).keyboardType(.numberPad)
                                .onReceive(Just(pieces)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.viewModel.purchase.pieces = "\(filtered)"
                                }
                                }.onAppear(){pieces = viewModel.purchase.pieces}
                                .onChange(of: viewModel.purchase.pieces){ newValue in
                                    pieces = newValue
                                }
                        
                        Spacer().frame(height: 50)
                        
                        saveButton
                    }else{
                        //Vista en caso de nuevo registro
                        Component_TextField(textFieldTitle: "ida", textFieldText: $ida).keyboardType(.numberPad)
                                .onReceive(Just(ida)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.ida = "\(filtered)"
                                }
                              }
                                .onChange(of: ida){newValue in
                                    viewModel.purchase.ida = newValue
                                    ida = newValue
                                }
                                
                        
                        Component_TextField(textFieldTitle: "Name", textFieldText: $name).onAppear(){viewModel.purchase.name = name}.onChange(of: name) { newValue in
                            viewModel.purchase.name = newValue
                            name = newValue
                        }
                            
                        Component_TextField(textFieldTitle: "Pieces", textFieldText: $pieces).keyboardType(.numberPad)
                                .onReceive(Just(pieces)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.pieces = "\(filtered)"
                                    viewModel.purchase.ida = pieces
                                }
                                }.onChange(of: pieces){newValue in
                                    viewModel.purchase.pieces = newValue
                                    pieces = newValue
                                }
                        
                        Spacer().frame(height: 50)
                        
                        saveButton
                    }
                    
                }
            }//Fin de Vstack
            )//Cierre de Overlay
            .foregroundColor(.white)
        }.foregroundColor(.white).accentColor(.white)
    }//Fin de view
    
    // Validation
    func validateFields(){
        print(name + " " + pieces + " " + ida)
        if([name,pieces,ida].contains("")){
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
      viewModel.handleDoneTapped()
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


