import SwiftUI

struct SaleRowView: View {
    var sale: SalesB
    var body: some View {
        HStack{
            Image(systemName: "tag.fill")
                .resizable()
                .frame(width: 40, height: 40).padding(10)
            VStack(alignment: .leading){
                Text(sale.name).font(.title)
                HStack{
                   // Text("Name:"+sale.name).font(.subheadline)
                    Text("Quantity:"+sale.quantity).font(.subheadline)
                    Text("Total:"+sale.total).font(.subheadline)
                }
            }
        }
    }
}

struct SaleRowView_Previews: PreviewProvider {
    static var previews: some View {
        SaleRowView(sale: SalesB(name: "", quantity: "", idv: "", idc: "", pieces: "", subtotal: "", total: ""))
            .previewLayout(
                .fixed(width: 400, height: 60))
    }
}
