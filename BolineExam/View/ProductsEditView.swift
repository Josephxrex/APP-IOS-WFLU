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
    
    @State private var showAlert = false;
    @State private var title = "";
    @State private var message = "";
    
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }.foregroundColor(Color(.red))
            .font(.headline)
            .frame(width: 220, height: 60)
    }
     
    var saveButton: some View {
      Button(action: { validateFields() }) {
          Text(mode == .new ? "Done" : "Save").foregroundColor(Color("Inputs"))
      }
      .alert(isPresented: $showAlert){
      Alert(title: Text(title), message: Text(message))
      }
      .disabled(!viewModel.modified)
      .foregroundColor(Color.white)
            .font(.headline)
            .frame(width: 220, height: 60)
    }
    
    var body: some View {
        NavigationView{
           Color("Fondo").edgesIgnoringSafeArea(.all).overlay(
                VStack{
                    Section(header: Component_Title(titleText: "Product")) {
                    Component_TextField(textFieldTitle: "Name", textFieldText: $viewModel.product.name)
                        
                    Component_TextField(textFieldTitle: "Description", textFieldText: $viewModel.product.description)
                        
                    
                    TextField("Units", text:$viewModel.product.units).padding()
                        .background(Color("Inputs"))
                        .foregroundColor(.white)
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.units)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.units = "\(filtered)"
                        }
                        }
                    
                    TextField("Cost", text:$viewModel.product.cost).padding()
                        .background(Color("Inputs"))
                        .foregroundColor(.white)
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.cost)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.cost = "\(filtered)"
                        }
                        }
                    
                    TextField("Price", text:$viewModel.product.price).padding()
                        .background(Color("Inputs"))
                        .foregroundColor(.white)
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.price)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.price = "\(filtered)"
                        }
                        }
                    
                    TextField("Utility", text:$viewModel.product.utility).padding()
                        .background(Color("Inputs"))
                        .foregroundColor(.white)
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewModel.product.utility)){
                        value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.viewModel.product.utility = "\(filtered)"
                        }
                        }
                    
                        if mode == .edit {
                            Section {
                                Button("Delete Product") { self.presentActionSheet.toggle() }
                                    .foregroundColor(.red)
                                    .font(.headline)
                                    .padding()
                            }
                        }
            }
        }//Fin de vstack
            )//Cierre de Overlay
            .foregroundColor(.white)
            .navigationTitle(mode == .new ? "New Product" : "Edit:"+viewModel.product.name).foregroundColor(.white)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
              leading: cancelButton,
              trailing: saveButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
              ActionSheet(title: Text("Are you sure?"),
                          buttons: [
                            .destructive(Text("Delete Product"),
                                         action: { self.handleDeleteTapped() }),
                            .cancel()
                          ])
            }
    }.foregroundColor(.white).accentColor(.white)//Fin de NavigationView
}//Fin de view
    
    // Validation 
    func validateFields(){
        if([viewModel.product.name, viewModel.product.units, viewModel.product.cost, viewModel.product.price, viewModel.product.utility].contains("")){
            title = "Error"
            message = "One or more fields are empty"
            showAlert.toggle()
        }else{
            title="Success"
            message="The fields were saved succesfully"
            showAlert.toggle()
            self.handleDoneTapped()
        }
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
