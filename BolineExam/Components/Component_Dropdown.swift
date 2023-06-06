//
//  Component_Dropdown.swift
//  BolineExam
//
//  Created by ISSC_611_2023 on 05/06/23.
//

import SwiftUI



struct Component_Dropdown: View {
    
    @State private var isExpanded = false
    @State private var selectedItem = "Products"
    @State private var quantity = ""
    
    @StateObject var productsViewModel = ProductsViewModel()
    
    var body: some View {
        DisclosureGroup("\(selectedItem)", isExpanded: $isExpanded){
            VStack{
                ForEach(productsViewModel.products){
                    item in
                    Text("\(item.name)")
                        .padding(.all)
                        .onTapGesture(){
                            self.selectedItem = String(item.name)
                            self.quantity = String(item.units)
                            withAnimation{
                                self.isExpanded.toggle()
                            }
                            
                        }
                }
            }
        }.accentColor(.white)
            .foregroundColor(.white)
            .padding(.all)
            .background(Color("Inputs"))
            .cornerRadius(5.0)
            .padding(.horizontal)
            .onAppear() {
               productsViewModel.subscribe()
           }
        
        Text("Quantity Available: \(quantity)")
        
        
    }
}

struct Component_Dropdown_Previews: PreviewProvider {
    static var previews: some View {
        Component_Dropdown()
    }
}
