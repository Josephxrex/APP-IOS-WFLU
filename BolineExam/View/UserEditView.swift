import SwiftUI
 
enum ModeUser {
  case new
  case edit
}
 
enum ActionUser {
  case delete
  case done
  case cancel
}
 
struct UserEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = UserViewModels()
    var mode: ModeUser = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save").foregroundColor(Color("Inputs"))
      }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
          Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
          VStack{
              Section(header: Text("User Name").font(.largeTitle)) {
                  TextField("Name", text: $viewModel.user.name).padding()
                      .background(Color("Inputs"))
                      .foregroundColor(.white)
                      .cornerRadius(5.0)
                      .padding(.horizontal)
                  
                  TextField("LastName", text: $viewModel.user.lastname).padding()
                      .background(Color("Inputs"))
                      .foregroundColor(.white)
                      .cornerRadius(5.0)
                      .padding(.horizontal)
                  
                  TextField("Age", text: $viewModel.user.age).padding()
                      .background(Color("Inputs"))
                      .foregroundColor(.white)
                      .cornerRadius(5.0)
                      .padding(.horizontal)
                  
                  TextField("Gender", text: $viewModel.user.gender).padding()
                      .background(Color("Inputs"))
                      .foregroundColor(.white)
                      .cornerRadius(5.0)
                      .padding(.horizontal)
                  
                  TextField("E-mail", text: $viewModel.user.email).padding()
                      .background(Color("Inputs"))
                      .foregroundColor(.white)
                      .cornerRadius(5.0)
                      .padding(.horizontal)
                  
                  TextField("Password", text: $viewModel.user.password).padding()
                      .background(Color("Inputs"))
                      .foregroundColor(.white)
                      .cornerRadius(5.0)
                      .padding(.horizontal)
              }
              
              if mode == .edit {
                  Section {
                      Button("Delete User") { self.presentActionSheet.toggle() }
                          .foregroundColor(.red)
                          .font(.headline)
                          .padding()
                  }
              }
          }//Fin de Vstack
          )//Cierre de Overlay
          .foregroundColor(.white)
        .navigationTitle(mode == .new ? "New User" : "Edit:"+viewModel.user.name).foregroundColor(.white)
        .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
        .navigationBarItems(
          leading: cancelButton,
          trailing: saveButton
        )
        .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete User"),
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
 
//struct MovieEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieEditView()
//    }
//}
 
struct MovieEditView_Previews: PreviewProvider {
  static var previews: some View {
    let user = UserB(name:"Pigy",lastname:"Puerk",age: "23",gender: "M",email: "",password: "")
    let userViewModel = UserViewModels(user: user)
    return UserEditView(viewModel: userViewModel, mode: .edit)
  }
}
