import SwiftUI

struct Component_Button: View {
    @State public var buttonTitle: String
        var action: (() -> Void)?
    
    var body: some View {
        Button(buttonTitle){
            // Aquí puedes agregar la acción que se ejecutará al hacer clic en el botón de inicio de sesión
            self.action?() 
        }.font(.headline)
            .foregroundColor(Color(red: 0, green: 0.333, blue: 0.455))
            .frame(width: 320, height: 50)
            .background(Color("Botones"))
            .cornerRadius(30)
    }
}
