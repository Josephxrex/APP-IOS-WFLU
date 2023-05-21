import SwiftUI

struct UsersListView: View {
    
    //Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddUserSheet = false
    
    @StateObject var userViewModel = UsersViewModel()
    
    //Funciones
    private func addButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("+").font(.largeTitle).foregroundColor(Color("FondoList"))
        }
    }
    
    

    
    var body: some View {
        NavigationView{
            List{
                ForEach(userViewModel.users) {
                    user in NavigationLink(destination: UserDetailView(user: user)){
                        UserRowView(user:user)
                    }.listRowBackground(Color("FondoList"))
                }
                .onDelete(){
                    indexSet in userViewModel.removeUsers(atOffsets: indexSet)
                }
            }.background(Color("Fondo")).scrollContentBackground(.hidden)
            .navigationTitle("Users")
                .navigationBarItems(trailing: addButton {
                    self.presentAddUserSheet.toggle()
            })
            .onAppear(){
                    userViewModel.subscribe()
                }
            .sheet(isPresented: self.$presentAddUserSheet){
                let user = UserB(name:"",lastname:"",age: "",gender: "",email: "",password: "")
                UserEditView(viewModel: UserViewModels(user: user), mode: .new) { result in
                    if case .success(let action) = result, action == .delete {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
