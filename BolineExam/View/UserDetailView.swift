import SwiftUI

struct UserDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
    
    var user: UserB
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit").foregroundColor(Color("FondoList"))
        }
    }
    
    //CUERPO
    var body: some View {
        VStack {
            Form {
                Section(header: Text("User")) {
                    Text(user.name)
                    Text(user.lastname)
                    Text(user.gender)
                    Text(user.age)
                    Text(user.email)
                }.listRowBackground(Color("FondoList")).foregroundColor(.white)
            }.background(Color("Fondo")).scrollContentBackground(.hidden)
            .navigationBarTitle(user.name)
            .navigationBarItems(trailing: editButton {
                self.presentEditMovieSheet.toggle()
            })
            .onAppear() {
                print("UserDetailsView.onAppear() for \(self.user.name)")
            }
            .onDisappear() {
                print("UserDetailsView.onDisappear()")
            }
            .sheet(isPresented: self.$presentEditMovieSheet) {
                UserEditView(viewModel: UserViewModels(user: user), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    struct MovieDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            let user = UserB(name:"",lastname:"",age: "",gender: "",email: "",password: "")
            return
                NavigationView {
                    UserDetailView(user: user)
                }
            }
        }
}
