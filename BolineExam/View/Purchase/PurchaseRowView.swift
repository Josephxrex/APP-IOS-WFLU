import SwiftUI

struct PurchaseRowView: View {
    var purchase: PurchaseB
    var body: some View {
        HStack{
            Image(systemName: "cart.fill")
                .resizable()
                .frame(width: 40, height: 40).padding(10)
                .foregroundColor(Color("Iconos"))
            VStack(alignment: .leading){
                Text(purchase.name).font(.title)
                HStack{
                    Text("ida:"+purchase.ida).font(.subheadline)
                    Text("Pieces:"+purchase.pieces).font(.subheadline)
                }
            }.foregroundColor(Color.white)
        }
    }
}
