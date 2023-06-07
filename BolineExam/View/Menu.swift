import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Menu: View {
    // Variables de estado
    @State private var email = ""
    @State private var password = ""
    @State private var mensaje = ""
    @State private var alert = false
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
        
        Button(action: {
            userIsLogged.toggle()
                }) {
                    Image(systemName: "power")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
        
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
        }).navigationBarItems(leading: Image("CotlineStore").resizable().accentColor(Color.white)
            .scaledToFit()
            .frame(width: 100, height: 100)
            .foregroundColor(.white), trailing: logOutButton)
        }.accentColor(Color.white)//Fin del NavigationView
    }//Fin del body
}//Fin del MenuView


    
