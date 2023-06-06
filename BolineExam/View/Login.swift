import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    @State private var userIsLogged = false
    @State private var alerta = false

    var correo = false
    var contrasenia = false
    @State private var isValidated: Bool = false
    @State private var showSecondScreen: Bool = false
    
    
    var body: some View {
        if userIsLogged {
            Menu()
        }else{
            contenido
        }
    }
    
    var contenido: some View {
            Color("Fondo").edgesIgnoringSafeArea(.all).overlay(VStack {
            
                VStack {
                    Component_Title(titleText: "Let's sign you in")
                    Component_Subtitle(subtitleText: "Welcome back")
                    Component_Subtitle(subtitleText: "You have been missed!")
                    Spacer().frame(height: 50)
                }
                VStack{
                    Component_TextField(textFieldTitle: "Email", textFieldText: $email)
                    Spacer().frame(height: 20)
                    Component_SecureField(secureFieldTitle: "Password", secureFieldText: $password)
                    Spacer().frame(height: 50)
                    Component_Button(buttonTitle: "Log In", action: checkLogin).alert(isPresented: $alerta){
                        Alert(title: Text("Alert"),message:Text("\(message)"),dismissButton: .default(Text("Ok")))
                    }
                    Component_Subtitle(subtitleText: "Don't have an account?")
                    Component_Subtitle(subtitleText: "Write your email and password in the fields and press:")
                    Component_Button(buttonTitle: "Register", action: registerForLogin).alert(isPresented: $alerta){
                        Alert(title: Text("Alert"),message:Text("\(message)"),dismissButton: .default(Text("Ok")))
                    }
                }
            }.foregroundColor(.white).accentColor(.white)
                .padding()
        )

    }
    //Funciones

    
    func checkLogin(){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
                alerta.toggle()
                message = "The mail and password could already exist"
            }
            if (email == "" || password == ""){
                alerta.toggle()
                message = "You must enter a valid email and a password with 6 or more characters"
            }else{
                userIsLogged.toggle()
                alerta.toggle()
                message = "Validation Completed"
            }
        } // Fin de auth
    }// Fin de checkLogin
    
    func registerForLogin(){
        Auth.auth().createUser(withEmail: email, password: password) { authCreationResult, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            if (email == "" || password == ""){
                alerta.toggle()
                message = "You must enter a valid email and a password with 6 or more characters"
            }else{
                alerta.toggle()
                message = "User succesfully created"
            }
        }//Fin de auth
    }//Fin de registerForlogin
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

// Emails and passwords
// Created
// pigy@mail.com 123456
// cordero@mail.com 123456
// cris@mail.com 123456
// Not created yet
// efra@mail.com 123456
// cocho@mail.com 123456

