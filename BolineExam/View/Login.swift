//
//  Login.swift
//  BolineExam
//
//  Created by ISSC_612_2023 on 12/05/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var mensaje = ""
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
                    Text("Let's sign you in")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white).padding(.leading)
                    Text("Welcome back").frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.white).padding(.horizontal)
                    Text("You have been missed!").frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.white).padding(.horizontal)
                    Spacer().frame(height: 50)
                }
                VStack{
                    Component_TextField(textFieldTitle: "Email", textFieldText: $email)
                    
                    Spacer().frame(height: 20)

                    Component_SecureField(secureFieldTitle: "Password", secureFieldText: $password)
                    
                    Spacer().frame(height: 50)
                    
                    Button("Log in"){
                        // Aquí puedes agregar la acción que se ejecutará al hacer clic en el botón de inicio de sesión
                        checkLogin()
                    }.font(.headline)
                        .foregroundColor(Color(red: 0, green: 0.333, blue: 0.455))
                        .frame(width: 320, height: 50)
                        .background(Color("Botones"))
                        .cornerRadius(30)
                        .alert(isPresented: $alerta){
                            Alert(title: Text("Alerta"),message:Text("\(mensaje)"),dismissButton: .default(Text("Ok")))
                        }
                    
                    VStack {
                        Text("Don't have an account?")
                        Text("Write your email and password in the fields and press:").multilineTextAlignment(.center)
                        Button("Register"){
                            registerForLogin()
                        }.alert(isPresented: $alerta){
                            Alert(title: Text("Alerta"),message:Text("\(mensaje)"),dismissButton: .default(Text("Ok")))
                        }
                        
                    }.foregroundColor(.white)
                    
                }

            }.foregroundColor(.white).accentColor(.white)
                .padding()
        )
//        }.foregroundColor(.white).accentColor(.white)
    }
    //Funciones

    
    func checkLogin(){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                userIsLogged.toggle()
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
                mensaje = "You must enter a valid email and a password with 6 or more characters"
            }else{
                alerta.toggle()
                mensaje = "User succesfully created"
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
//
// pigy@mail.com 123456
// cordero@mail.com 123456
// cris@mail.com 123456
// efra@mail.com 123456
// cocho@mail.com 123456

