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