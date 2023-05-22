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
    
    @State private var alerta = false
    
    var correo = false
    var contrasenia = false
    @State private var isValidated: Bool = false
    @State private var showSecondScreen: Bool = false
    
    
    var body: some View {
        NavigationView{
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
