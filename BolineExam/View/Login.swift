import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Login: View {
    @State private var email = "cordero@mail.com"
    @State private var password = "123456"
    @State private var message = ""
    @State private var userIsLogged: Bool = false
    @State private var alert = false
    @State private var isValidated: Bool = false
    @State private var showSecondScreen: Bool = false
    var correo = false
    var contrasenia = false
    
    
    var body: some View {
        if userIsLogged {
            Menu(userIsLogged: $userIsLogged)
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
                    
                    Component_ButtonSecondary(buttonTitle: "Log In", action: checkLogin).alert(isPresented: $alert){
                        Alert(title: Text("Alert"),message:Text("\(message)"),dismissButton: .default(Text("Ok")))
                    }
                    
                    Spacer().frame(height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("Don't have an account?").multilineTextAlignment(.leading).bold()
                        HStack {
                            Text("Write your credentials and press")
                            Text("Register").bold()
                        }
                    }
                    
                    Component_Button(buttonTitle: "Register", action: registerForLogin).alert(isPresented: $alert){
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
                alert.toggle()
                message = "The mail and password could already exist"
            }
            if (email == "" || password == ""){
                alert.toggle()
                message = "You must enter a valid email and a password with 6 or more characters"
            }else{
                userIsLogged.toggle()
                /*alert.toggle()
                message = "Validation Completed"*/
            }
        } // Fin de auth
    }// Fin de checkLogin
    
    func registerForLogin(){
        Auth.auth().createUser(withEmail: email, password: password) { authCreationResult, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            if (email == "" || password == ""){
                alert.toggle()
                message = "You must enter a valid email and a password with 6 or more characters"
            }else{
                alert.toggle()
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

