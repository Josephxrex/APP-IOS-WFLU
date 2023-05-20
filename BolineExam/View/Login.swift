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
    
    @State private var alerta = false
    
    var correo = false
    var contrasenia = false
    @State private var isValidated: Bool = false
    @State private var showSecondScreen: Bool = false
    
    
    var body: some View {
        NavigationView{
            Color("Fondo").edgesIgnoringSafeArea(.all).overlay(VStack {
                Text("Login").font(.largeTitle).foregroundColor(Color.white)
                
                Component_TextField(textFieldTitle: "Email", textFieldText: $email)
                
                Spacer().frame(height: 20)
                

                Component_SecureField(secureFieldTitle: "Password", secureFieldText: $password)
                
                Spacer().frame(height: 20)
                
                Button("Login"){
                    // Aquí puedes agregar la acción que se ejecutará al hacer clic en el botón de inicio de sesión
                    checkLogin()
                }.foregroundColor(Color.white)
                    .font(.headline)
                    .frame(width: 220, height: 60)
                    .alert(isPresented: $alerta){
                        Alert(title: Text("Alerta"),message:Text("\(mensaje)"),dismissButton: .default(Text("Ok")))
                    }
                
                NavigationLink(destination: Menu(), isActive: $isValidated) {
                                    EmptyView()
                }
                

                
                NavigationLink(destination: UserEditView(), label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 220, height: 60)
                        .background(Color("Botones"))
                        .cornerRadius(15.0)
                        
                })
            }
            .padding()
        )
            
            
            
        }
    }
    

    
    func checkLogin(){
        if([email,password].contains("")){
            mensaje = "Ingresa todos los campos"
            alerta = true
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
