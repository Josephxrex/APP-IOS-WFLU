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
        Component_Button(buttonTitle: "Edit", action: action).frame(minHeight: 10, idealHeight: 10)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Fondo")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Component_Title(titleText: product.name)
                    Component_Subtitle(subtitleText: "Data")
                    
                    Form {
                        Section(header: Text("ID:" + (product.id ?? ""))) {
                            Component_DetailField(textTitle: "Name:", textValue: product.name)
                            Component_DetailField(textTitle: "Description:", textValue: product.description)
                            Component_DetailField(textTitle: "Units:", textValue: product.units)
                            Component_DetailField(textTitle: "Cost:", textValue: product.cost)
                            Component_DetailField(textTitle: "Price:", textValue: product.price)
                            Component_DetailField(textTitle: "Utility:", textValue: product.utility)
                        }
                        .listRowBackground(Color("FondoList"))
                        .foregroundColor(.white)
                        
                        editButton{
                            self.presentEditProductSheet.toggle()
                        }
                        
                    }
                    .background(Color("Fondo"))
                    .scrollContentBackground(.hidden)
                    .onAppear() {
                        print("ProductsDetailView.onAppear() for \(self.product.name)")
                    }
                    .onDisappear() {
                        print("ProductsDetailView.onDisappear()")
                    }
                    .sheet(isPresented: self.$presentEditProductSheet) {
                        ProductsEditView(viewModelProducts: ProductViewModel(product: product), mode: .edit) { result in
                            if case .success(let action) = result, action == .delete {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
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
}
