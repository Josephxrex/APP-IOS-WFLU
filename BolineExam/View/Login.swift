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
    
    
    
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Login").font(.largeTitle)
                
                Component_TextField(textFieldTitle: "Email", textFieldText: $email)
                
                Spacer().frame(height: 20)
                
                Component_SecureField(secureFieldTitle: "Password", secureFieldText: $password)
                
                Spacer().frame(height: 20)
                
                Button("Login"){
                    // Aquí puedes agregar la acción que se ejecutará al hacer clic en el botón de inicio de sesión
                    checkLogin()
                }.foregroundColor(Color.blue)
                    .font(.headline)
                    .frame(width: 220, height: 60)
                    .alert(isPresented: $alerta){
                        Alert(title: Text("Alerta"),message:Text("\(mensaje)"),dismissButton: .default(Text("Ok")))
                    }
                
                NavigationLink(destination: ProductsEditView(), label: {
                    Text("Sign Up").foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                })
            }
            .padding()
            
            
        }
    }
    
    func checkLogin() {
        if([email,password].contains("")){
            mensaje = "Ingresa todos los campos"
            alerta = true
        } else {
        if(email == "correo@gmail.com" && password == "contraseña"){
            //NavigationLink(destination: Menu()){
                
            //}
        }}
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
