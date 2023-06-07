import SwiftUI
import Combine
 
enum ModeUser {
  case new
  case edit
}
 
enum ActionUser {
  case delete
  case done
}
 
struct UserEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @ObservedObject var viewModel = UserViewModels()
    
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    var mode: ModeUser = .new
    var completionHandler: ((Result<ActionUser, Error>) -> Void)?
     
    private func saveButton(action: @escaping () -> Void) -> some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: action).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
            .disabled(!viewModel.modified)
    }
     
    var body: some View {
        NavigationView {
            Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
                VStack{
                    Section (header: Component_Title(titleText: mode == .new ? "New user" : "Edit user")) {
                        
                        Component_TextField(textFieldTitle: "Name", textFieldText: $viewModel.user.name)
                        
                        Component_TextField(textFieldTitle: "LastName", textFieldText: $viewModel.user.lastname)
                        
                        Component_TextField(textFieldTitle: "Age", textFieldText: $viewModel.user.age).keyboardType(.numberPad)
                            .onReceive(Just(viewModel.user.age)){
                                value in
                                let filtered = "\(value)".filter { "0123456789".contains($0) }
                                if filtered != value {
                                    self.viewModel.user.age = "\(filtered)"
                                }
                            }
                        
                        Component_TextField(textFieldTitle: "Gender", textFieldText: $viewModel.user.gender)
                        
                        Component_TextField(textFieldTitle: "E-mail", textFieldText: $viewModel.user.email).keyboardType(.emailAddress)
                        
                        Component_SecureField(secureFieldTitle: "Password", secureFieldText: $viewModel.user.password)
                        
                        Spacer().frame(height: 50)
                        
                        saveButton(action: validateFields)
                    }
                }
                ).foregroundColor(.white)
                }.foregroundColor(Color.white).accentColor(Color.white)
        }

     
    // Validation
    func validateFields(){
        if([viewModel.user.name, viewModel.user.password,viewModel.user.gender, viewModel.user.age, viewModel.user.email, viewModel.user.lastname].contains("")){
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
 
struct MovieEditView_Previews: PreviewProvider {
  static var previews: some View {
    let user = UserB(name:"Pigy",lastname:"Puerk",age: "23",gender: "M",email: "",password: "")
    let userViewModel = UserViewModels(user: user)
    return UserEditView(viewModel: userViewModel, mode: .edit)
  }
}
