import SwiftUI

var saleViewModel = SalesViewModel()

struct SalesListView: View {
    var body: some View {
        NavigationView{
            List{
                ForEach(saleViewModel.sales) {
                    sale in NavigationLink(destination: SalesDetailView(sale: sale)){
                        SaleRowView(sale:sale)
                    }
                }
                .onDelete(){
                    indexSet in userViewModel.removeUsers(atOffsets: indexSet)
                }
            }.onAppear(){
                    userViewModel.subscribe()
                }
        }.navigationTitle("Sales")
    }
}

struct SalesListView_Previews: PreviewProvider {
    static var previews: some View {
        SalesListView()
    }
}
