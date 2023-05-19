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
        NavigationView{
            VStack {
                    Section(header: Text("Purchase data")) {
                        //Unidades
                        TextField("ida", text:$viewModel.purchase.ida).padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5.0)
                            .padding(.horizontal)
                            .keyboardType(.numberPad)
                            .onReceive(Just(viewModel.purchase.pieces)){
                            value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.viewModel.purchase.pieces = "\(filtered)"
                            }
                            }
                        
                        TextField("Name", text:$viewModel.purchase.name).padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5.0)
                            .padding(.horizontal)

                        TextField("Units", text:$viewModel.purchase.pieces).padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5.0)
                            .padding(.horizontal)
                            .keyboardType(.numberPad)
                            .onReceive(Just(viewModel.purchase.pieces)){
                            value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.viewModel.purchase.pieces = "\(filtered)"
                            }
                            }
                            
                    }
                    
                    if mode == .edit {
                     Section {
                      Button("Delete Purchase") { self.presentActionSheet.toggle()
                          self.handleDeleteTapped()
                      }
                        .foregroundColor(.red)
                     }
                    }
                }
            .navigationTitle(mode == .new ? "New Purchase" : "Edit:"+viewModel.purchase.name)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
              leading: cancelButton,
              trailing: saveButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
              ActionSheet(title: Text("Are you sure?"),
                          buttons: [
                            .destructive(Text("Delete Purchase"),
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

struct Purchase_Previewss: PreviewProvider {
    static var previews: some View {
        PurchaseEditView()
    }
}


