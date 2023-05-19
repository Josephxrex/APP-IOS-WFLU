//
//  ContentView.swift
//  BolineExam
//
//  Created by ISSC_612_2023 on 12/05/23.
//

import SwiftUI

struct ContentView: View {
    let product = Product(name: "name product", description: "this is a sample description", units: "4", cost: "3", price: "2", utility: "1")
    var body: some View {
        //ProductDetailsView(product: product)
        //Login()
        SalesListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
