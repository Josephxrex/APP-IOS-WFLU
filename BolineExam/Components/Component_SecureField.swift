//
//  Component_SecureField.swift
//  BolineExam
//
//  Created by Cristian Axel Gonzalez Rodriguez on 15/05/23.
//

import Foundation
import SwiftUI

struct Component_SecureField: View {
    @State var secureFieldTitle: String
    @State var secureFieldText: Binding<String>
    
    var body: some View {
        SecureField(secureFieldTitle, text: secureFieldText).padding()
            .background(Color("Inputs"))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
            .padding(.horizontal)
    }
}

