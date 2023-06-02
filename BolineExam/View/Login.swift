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
    @State private var email = "correo@gmail.com"
    @State private var password = "contraseña"
    @State private var mensaje = ""
    
    @State var alertMessage = ""
    @State private var showAlert = false
    
    var correo = false
    var contrasenia = false
    @State private var isValidated: Bool = false
    @State private var showSecondScreen: Bool = false
    
    
    var body: some View {
        NavigationView{
            Color("Fondo").edgesIgnoringSafeArea(.all).overlay(VStack {
            
                VStack {
                    Component_Title(titleText: "Let's sign you in")
                    Component_Subtitle(subtitleText: "Welcome back")
                    Component_Subtitle(subtitleText: "You have been missed!")
                    Spacer().frame(height: 50)
                }
                
                Component_TextField(textFieldTitle: "Email", textFieldText: $email)
                
                Spacer().frame(height: 20)

                Component_SecureField(secureFieldTitle: "Password", secureFieldText: $password)
                
                Spacer().frame(height: 50)
                
                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: UserEditView(), label: {
                        Text("Register").bold()
                    })
                    
                }.foregroundColor(.white)
                
                Component_Button(buttonTitle: "Log in", alertMessage: alertMessage, alert: $showAlert, action: checkLogin)

                                
                NavigationLink(destination: Menu(), isActive: $isValidated) {
                                    EmptyView()
                }
            }.foregroundColor(.white).accentColor(.white)
                .padding()
        )
            
            
            
        }.foregroundColor(.white).accentColor(.white)
    }
    
    
    func checkLogin(){
        if([email,password].contains("")){
            alertMessage = "Ingresa todos los campos"
            showAlert = true
        } else {
          if(email == "correo@gmail.com" && password == "contraseña"){
              isValidated = true
              
          }
        }
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
