//
//  ProductsListView.swift
//  BolineExam
//
//  Created by ISSC_611_2023 on 17/05/23.
//

import SwiftUI



var products = [Product(name: "name product", description: "this is a sample description", units: "4", cost: "3", price: "2", utility: "1"),Product(name: "PC GAMER", description: "prueba", units: "5", cost: "5", price: "4", utility: "7")]

struct ProductsListView: View {
    
    //Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddProductSheet = false
    
    @StateObject var productsViewModel = ProductsViewModel()
    
    //funciones
    private func addButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("+").font(.largeTitle)
        }
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(productsViewModel.products) { product in
                    NavigationLink(destination: ProductDetailsView(product: product)) {
                        ProductRowView(product: product)
                    }
                }
                .onDelete(){
                    indexSet in
                    productsViewModel.removeProducts(atOffsets: indexSet)
                }
            }.navigationTitle("Products")
                .navigationBarItems(trailing: addButton {
                    self.presentAddProductSheet.toggle()
            })
             .onAppear() {
                productsViewModel.subscribe()
            }
             .sheet(isPresented: self.$presentAddProductSheet){
                 let product = Product(name: "", description: "", units: "", cost: "", price: "", utility: "")
                 ProductsEditView(viewModel: ProductViewModel(product: product), mode: .new) { result in
                     if case .success(let action) = result, action == .delete {
                         self.presentationMode.wrappedValue.dismiss()
                     }
                 }
             }

        }
        
    }
    
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView()
    }
}
