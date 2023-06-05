//
//  ProductsDetailView.swift
//  BolineExam
//
//  Created by ISSC_612_2023 on 12/05/23.
//
//ProductDetailsView

import SwiftUI
 
struct ProductDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditProductSheet = false
     
    var product: Product
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
          Text("Edit").foregroundColor(Color("FondoList"))
      }
    }
     
    var body: some View {
      Form {
        Section(header: Text("Product")) {
          Text(product.name)
          Text(product.description)
          Text(product.units)
          Text(product.cost)
          Text(product.price)
          Text(product.utility)
             
        }.listRowBackground(Color("FondoList")).foregroundColor(.white)
      }.background(Color("Fondo")).scrollContentBackground(.hidden)
            .navigationBarTitle(Text("Product"))
      .navigationBarItems(trailing: editButton {
        self.presentEditProductSheet.toggle()
      })
      .onAppear() {
        print("ProductsDetailView.onAppear() for \(self.product.name)")
      }
      .onDisappear() {
        print("ProductsDetailView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditProductSheet) {
        ProductsEditView(viewModel: ProductViewModel(product: product), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
     
  }
 
struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(name: "name product", description: "this is a sample description", units: "4", cost: "3", price: "2", utility: "1")
        return
          NavigationView {
            ProductDetailsView(product: product)
          }.foregroundColor(.white).accentColor(.white)
    }
}
