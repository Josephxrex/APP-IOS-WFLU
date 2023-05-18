import SwiftUI

struct ProductRowView: View {
    var product: Product
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 40, height: 40).padding(10)
            VStack(alignment: .leading){
                Text(product.name).font(.title)
                HStack{
                    Text("Price:"+product.price).font(.subheadline)
                    Text("Units:"+product.units).font(.subheadline)
                }
            }
        }
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: Product(name: "PC GAMER", description: "prueba", units: "5", cost: "5", price: "4", utility: "7"))
            .previewLayout(
                .fixed(width: 400, height: 60))
    }
}
