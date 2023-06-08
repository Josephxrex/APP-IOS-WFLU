import SwiftUI

struct UserDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditUserSheet = false
    
    var user: UserB
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Component_Button(buttonTitle: "Edit", action: action).frame(minHeight: 10, idealHeight: 10)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Fondo")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Component_Title(titleText: user.name)
                    Component_Subtitle(subtitleText: "Data")
                    
                    Form {
                        Section(header: Text("ID:" + (user.id ?? ""))) {
                            Component_DetailField(textTitle: "Name:", textValue: user.name)
                            Component_DetailField(textTitle: "Last name:", textValue: user.lastname)
                            Component_DetailField(textTitle: "Gender:", textValue: user.gender)
                            Component_DetailField(textTitle: "Age:", textValue: user.age)
                            Component_DetailField(textTitle: "E-mail:", textValue: user.email)
                        }
                        .listRowBackground(Color("FondoList"))
                        .foregroundColor(.white)
                        
                        editButton{
                            self.presentEditUserSheet.toggle()
                        }
                        
                    }
                    .background(Color("Fondo"))
                    .scrollContentBackground(.hidden)
                    .onAppear() {
                        print("ProductsDetailView.onAppear() for \(self.user.name)")
                    }
                    .onDisappear() {
                        print("ProductsDetailView.onDisappear()")
                    }
                    .sheet(isPresented: self.$presentEditUserSheet) {
                        UserEditView(viewModelUser: UserViewModels(user: user), mode: .edit) { result in
                            if case .success(let action) = result, action == .delete {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
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
