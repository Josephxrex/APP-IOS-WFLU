//
//  Login.swift
//  BolineExam
//
//  Created by ISSC_612_2023 on 12/05/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct Menu: View {
    @State private var email = ""
    @State private var password = ""
    @State private var mensaje = ""
    
    @State private var alerta = false
    
    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let iconName: String
        let destination: AnyView
    }
    
    let items = [
        Item(title: "Users", iconName: "person.fill", destination: AnyView(UsersListView())),
        Item(title: "Purchases", iconName: "cart.fill", destination: AnyView(PurchasesListView())),

        Item(title: "Sales", iconName: "tag.fill", destination: AnyView(SalesListView())),
        Item(title: "Products", iconName: "bag.fill", destination: AnyView(ProductsListView())),
             
        ]
    

    var body: some View {

        Color("Fondo").edgesIgnoringSafeArea(.all).overlay(VStack{
            Text("Welcome back!")
                .font(.largeTitle.bold()).padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
            Text("Pick up where you left off").frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.white).padding(.horizontal)
        

        
                    List(items) { item in
                        NavigationLink(destination: item.destination.edgesIgnoringSafeArea(.all)) {
                            HStack {
                                Image(systemName: item.iconName)
                                    .foregroundColor(Color("Iconos"))
                                Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }.listRowBackground(Color("FondoList"))
                    }.background( Color("Fondo")).scrollContentBackground(.hidden)
        })
        }
    }


    
