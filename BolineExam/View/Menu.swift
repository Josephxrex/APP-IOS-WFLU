import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Menu: View {
    // Variables de estado
    @State private var email = ""
    @State private var password = ""
    @State private var mensaje = ""
    @State private var alerta = false
    @Binding var userIsLogged : Bool
    //Recepción de datos de la lista
    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let iconName: String
        let destination: AnyView
    }
    let items = [
        Item(title: "Users", iconName: "person.fill", destination: AnyView(UsersListView())),
        Item(title: "Purchases", iconName: "cart.fill", destination: AnyView(PurchasesListView())),

        Item(title: "Sales", iconName: "tag.fill", destination: AnyView(SalesListView())),
        Item(title: "Products", iconName: "bag.fill", destination: AnyView(ProductsListView())),
        ]
    
    //Variable que llegan a fungir como componentes
    var logOutButton: some View {
      Button("Log Out"){
          userIsLogged.toggle()
      }.foregroundColor(Color("Inputs"))
        
        //Text("Log Out").foregroundColor(Color("Inputs"))
      
    }//Fin de logOutButton
    
    // Cuerpo del Menú
    var body: some View {
        NavigationView{
        Color("Fondo").edgesIgnoringSafeArea(.all).overlay(VStack{
            Spacer().frame(height: 50)
            
            Component_Title(titleText: "Welcome back!")
            Component_Subtitle(subtitleText: "Pick up where you left off")
                        List(items) { item in
                            NavigationLink(destination: item.destination.edgesIgnoringSafeArea(.all)) {
                                HStack {
                                    Image(systemName: item.iconName)
                                        .foregroundColor(Color("Iconos"))
                                    Text(item.title)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }.listRowBackground(Color("FondoList")).foregroundColor(.white).accentColor(.white)
                        }.background( Color("Fondo")).scrollContentBackground(.hidden)
            })//Fin del overlay
                .navigationBarItems(
                trailing: logOutButton
              )
        }//Fin del NavigationView
    }//Fin del body
}//Fin del MenuView


    
