import SwiftUI
import Combine
import CryptoKit
 
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
    @ObservedObject var viewModelUser = UserViewModels()
    
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    //Variables para guardar los valores de los usuarios
    @State private var password = "";
    @State private var name = "";
    @State private var lastname = "";
    @State private var gender = "";
    @State private var age = "";
    @State private var email = "";
    
    var mode: ModeUser = .new
    var completionHandler: ((Result<ActionUser, Error>) -> Void)?
     
    var saveButton: some View {
        Component_Button(buttonTitle: mode == .new ? "Done" : "Save", action: validateFields).alert(isPresented: $showAlert){
            Alert(title: Text(title), message: Text(message))
            }
            
    }
     
    var body: some View {
        NavigationView {
            Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
                VStack{
                    Section (header: Component_Title(titleText: mode == .new ? "New user" : "Edit user")) {
                        if(mode == .edit){
                            //Vista en caso de actualización de registro
                            Component_TextField(textFieldTitle: "Name", textFieldText: $viewModelUser.user.name).onAppear(){name = viewModelUser.user.name}.onChange(of: viewModelUser.user.name){newValue in name = newValue}
                            
                            Component_TextField(textFieldTitle: "LastName", textFieldText: $viewModelUser.user.lastname).onAppear(){lastname = viewModelUser.user.lastname}.onChange(of: viewModelUser.user.lastname){newValue in lastname = newValue}
                            
                            Component_TextField(textFieldTitle: "Gender", textFieldText: $viewModelUser.user.gender).onAppear(){gender = viewModelUser.user.gender}.onChange(of: viewModelUser.user.gender){newValue in gender = newValue}
                            
                            Component_TextField(textFieldTitle: "Age", textFieldText: $viewModelUser.user.age).keyboardType(.numberPad)
                                .onReceive(Just(age)){
                                    value in
                                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                                    if filtered != value {
                                        self.viewModelUser.user.age = "\(filtered)"
                                    }
                                }.onAppear(){age = viewModelUser.user.age}
                                .onChange(of: viewModelUser.user.age){newValue in age = newValue}
                            
                            Component_TextField(textFieldTitle: "E-mail", textFieldText: $viewModelUser.user.email).keyboardType(.emailAddress)
                                                      .onAppear(){email = viewModelUser.user.email}
                                                      .onChange(of: viewModelUser.user.email){newValue in email = newValue}
                            
                            
                            Spacer().frame(height: 50)
                            
                            saveButton
                        }else{
                            //Vista en caso de nuevo registro
                            Component_TextField(textFieldTitle: "Name", textFieldText: $name).onChange(of: name){newValue in name = newValue
                                viewModelUser.user.name = newValue
                            }
                            
                            Component_TextField(textFieldTitle: "LastName", textFieldText: $lastname).onChange(of: lastname){newValue in lastname = newValue
                                viewModelUser.user.lastname = newValue
                            }
                            
                            Component_TextField(textFieldTitle: "Age", textFieldText: $age).keyboardType(.numberPad)
                                .onReceive(Just(viewModelUser.user.age)){
                                    value in
                                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                                    if filtered != value {
                                        self.viewModelUser.user.age = "\(filtered)"
                                    }
                                }.onChange(of: age){newValue in age = newValue
                                    viewModelUser.user.age = newValue
                                }
                            
                            Component_TextField(textFieldTitle: "Gender", textFieldText: $gender).onChange(of: gender){newValue in gender = newValue
                                viewModelUser.user.gender = newValue
                            }
                            
                            Component_TextField(textFieldTitle: "E-mail", textFieldText: $email).keyboardType(.emailAddress).onChange(of: email){newValue in email = newValue
                                viewModelUser.user.email = newValue
                            }
                            
                            Component_SecureField(secureFieldTitle: "Password", secureFieldText: $password).onChange(of: password){newValue in password = newValue
                                viewModelUser.user.password = newValue
                            }
                            
                            Spacer().frame(height: 50)
                            
                            saveButton
                        }
                    }
                }
                ).foregroundColor(.white)
                }.foregroundColor(Color.white).accentColor(Color.white)
        }

     
    // Validation
    func validateFields(){
        print(name,gender,age,email,lastname)
        viewModelUser.user.password = hashValue(viewModelUser.user.password)
        if([name,gender, age, email, lastname].contains("")){
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
    
    // Hash function
    func hashValue(_ value: String) -> String {
            if let inputData = value.data(using: .utf8) {
                let hashedData = SHA256.hash(data: inputData)
                let hashedString = hashedData.compactMap {
                    String(format: "%02x", $0)
                }.joined()
                
                return hashedString
            }
            
            return ""
        }
    
    // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
      viewModelUser.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
      viewModelUser.handleDeleteTapped()
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
    return UserEditView(viewModelUser: userViewModel, mode: .edit)
  }
}
