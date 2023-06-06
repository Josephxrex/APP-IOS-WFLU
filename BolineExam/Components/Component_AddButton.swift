import SwiftUI

struct Component_AddButton: View {
        var action: (() -> Void)?
    
    var body: some View {
        Button(action: { action!() }) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(Color("Fondo"))
                .frame(width: 56, height: 56)
                .background(Color("Botones"))
                .clipShape(Circle())
                .shadow(radius: 3)
        }
        .accentColor(.white)
    }
}
