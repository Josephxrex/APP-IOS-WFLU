import SwiftUI

struct SaleRowView: View {
    var sale: SalesB
    var body: some View {
        HStack{
            Image(systemName: "tag.fill")
                .resizable()
                .frame(width: 40, height: 40).padding(10)
                .foregroundColor(Color("Iconos"))
            VStack(alignment: .leading){
                Text(sale.name).font(.title)
                HStack{
                    Text("Quantity:"+sale.quantity).font(.subheadline)
                    Text("Total: $"+sale.total).font(.subheadline)
                }
            }.foregroundColor(Color.white)
        }
    }
}
