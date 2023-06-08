import SwiftUI

struct UsersListView: View {
    // Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddUserSheet = false
    
    @StateObject var userViewModel = UsersViewModel()
    
    // Funciones
    private func addButton(action: @escaping () -> Void) -> some View {
        Component_AddButton(action: action)
    }
    
    var body: some View {
            ZStack {
                Color("Fondo")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 200)
                    
                    List {
                        ForEach(userViewModel.users) { user in
                            NavigationLink(destination: UserDetailView(user: user)) {
                                UserRowView(user: user)
                            }
                            .listRowBackground(Color("FondoList"))
                        }
                        .onDelete() { indexSet in
                            userViewModel.removeUsers(atOffsets: indexSet)
                        }
                    }
                    .background(Color("Fondo"))
                    .scrollContentBackground(.hidden)
                    .onAppear() {
                        userViewModel.subscribe()
                    }
                    .sheet(isPresented: $presentAddUserSheet) {
                        let user = UserB(name: "", lastname: "", age: "", gender: "", email: "", password: "")
                        UserEditView(viewModelUser: UserViewModels(user: user), mode: .new) { result in
                            if case .success(let action) = result, action == .delete {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .accentColor(.white)
                .navigationBarTitleDisplayMode(.inline)
                VStack {
                    Spacer().frame(height: 110)
                    
                    Component_Subtitle(subtitleText: "List of")
                    Component_Title(titleText: "Users")
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        addButton {
                            presentAddUserSheet.toggle()
                        }
                    }
                    .padding(.trailing, 35)
                    .padding(.bottom, 35)
                }
            }
        
    }
    
    struct UsersListView_Previews: PreviewProvider {
        static var previews: some View {
            UsersListView()
        }
    }
}
