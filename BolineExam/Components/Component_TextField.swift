//
//  Component_TextField.swift
//  BolineExam
//
//  Created by Cristian Axel Gonzalez Rodriguez on 15/05/23.
//

import SwiftUI

struct Component_TextField: View {
    
    @State var textFieldTitle: String
    @State var textFieldText: Binding<String>
    
    var body: some View {
        TextField(textFieldTitle, text: textFieldText).padding()
            .background(Color("Inputs"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
            .padding(.horizontal)
    }
}
