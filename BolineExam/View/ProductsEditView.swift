//  ProductsEditView
//  Products.swift
//  ProyectoV1
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI
import Combine

enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}

struct ProductsEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentActionSheet = false
    @ObservedObject var viewModel = ProductViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?

    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Products").font(.largeTitle).padding()
                
                    Component_TextField(textFieldTitle: "Name", textFieldText: $viewModel.product.name)
                Component_TextField(textFieldTitle: "Description", textFieldText: $viewModel.product.description)
                    //Unidades
                Component_TextField(textFieldTitle: "Units", textFieldText: $viewModel.product.units)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.product.units)){
                    value in
                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                    if filtered != value {
                        self.viewModel.product.units = "\(filtered)"
                    }
                    };
                    //Costo
                Component_TextField(textFieldTitle: "Cost", textFieldText: $viewModel.product.cost)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.product.cost)){
                    value in
                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                    if filtered != value {
                        self.viewModel.product.cost = "\(filtered)"
                    }
                    };
                    //Precio
                Component_TextField(textFieldTitle: "Price", textFieldText: $viewModel.product.price)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.product.price)){
                    value in
                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                    if filtered != value {
                        self.viewModel.product.price = "\(filtered)"
                    }
                    };
                    //Utilidad
                Component_TextField(textFieldTitle: "Utility", textFieldText: $viewModel.product.utility)
                    .keyboardType(.numberPad)
                    .onReceive(Just(viewModel.product.utility)){
                    value in
                    let filtered = "\(value)".filter { "0123456789".contains($0) }
                    if filtered != value {
                        self.viewModel.product.utility = "\(filtered)"
                    }
                    };

                
                Button("Done") {
                    validateFields()
                }.padding()
                    .alert(isPresented: $showAlert){
                    Alert(title: Text(title), message: Text(message))
                    }

                

                if mode == .edit {
                 Section {
                  Button("Delete Product") { self.presentActionSheet.toggle()
                      self.handleDeleteTapped()
                  }
                    .foregroundColor(.red)
                 }
                }
                
                
            }
        }
    }
    
    //Validar campos
    func validateFields(){
        if([viewModel.product.name, viewModel.product.units, viewModel.product.cost, viewModel.product.price, viewModel.product.utility].contains("")){
            title = "Error"
            message = "One or more fields are empty"
            showAlert = true
        }else{
            self.handleDoneTapped()
            clean()
            title="Success"
            message="The fields were saved succesfully"
            showAlert = true
        }
    }
    
    func clean(){
        viewModel.product.name=""
        viewModel.product.description=""
        viewModel.product.units=""
        viewModel.product.cost=""
        viewModel.product.price=""
        viewModel.product.utility=""
    }

        // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
      self.viewModel.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
      viewModel.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        ProductsEditView()
    }
}
