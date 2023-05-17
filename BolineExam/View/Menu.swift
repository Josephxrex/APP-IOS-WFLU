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
    }
    
    let items = [
            Item(title: "Elemento 1", iconName: "icono1"),
            Item(title: "Elemento 2", iconName: "icono2"),
            Item(title: "Elemento 3", iconName: "icono3")
        ]
    
    var body: some View {
        Text("Welcome back!")
            .font(.largeTitle.bold()).padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading).padding(.top)
        Text("Pick up where you left off").frame(maxWidth: .infinity, alignment: .leading)
        
        NavigationView {
                    List(items) { item in
                        NavigationLink(destination: Text(item.title)) {
                            HStack {
                                Image(systemName: item.iconName)
                                    .foregroundColor(.blue)
                                Text(item.title)
                                    .font(.headline)
                            }
                        }
                    }
        }.padding()
        }
    }
    
