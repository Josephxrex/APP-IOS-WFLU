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
    
    
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save")
      }
      .disabled(!viewModel.modified)
    }
    var body: some View {
        NavigationView{
            VStack{
                
                Section(header: Text("Product data")) {
                    TextField("Name", text:$viewModel.product.name).padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                    
                    TextField("Description", text:$viewModel.product.description).padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.horizontal)
                    
                    TextField("Units", text:$viewModel.product.units).padding()
                        .background(Color.gray.opacity(0.2))
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
                        .background(Color.gray.opacity(0.2))
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
                        .background(Color.gray.opacity(0.2))
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
                        .background(Color.gray.opacity(0.2))
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
                  Button("Delete Product") { self.presentActionSheet.toggle()
                      self.handleDeleteTapped()
                  }
                    .foregroundColor(.red)
                 }
                }
            }
        }
            .navigationTitle(mode == .new ? "New Product" : "Edit:"+viewModel.product.name)
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
