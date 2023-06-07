import SwiftUI

struct Component_ButtonSecondary: View {
    @State public var buttonTitle: String
        var action: (() -> Void)?
        
        var body: some View {
            Button(action: {
                // Aquí puedes agregar la acción que se ejecutará al hacer clic en el botón de inicio de sesión
                self.action?()
            }) {
                Text(buttonTitle)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(width: 320, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
        }
}
