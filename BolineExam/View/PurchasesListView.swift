//
//  PurchasesListView.swift
//  BolineExam
//
//  Created by ISSC_611_2023 on 18/05/23.
//

import SwiftUI

struct PurchasesListView: View {
    //Variables de entorno y globales
    @Environment(\.presentationMode) var presentationMode
    @State var presentAddPurchaseSheet = false
    
    @StateObject var purchaseViewModel = PurchaseViewModels()
    
    //Funciones
    private func addButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("+").font(.largeTitle)
        }
    }
    
    
    var body: some View {
        NavigationView{
            List {
                ForEach(purchaseViewModel.purchases) { purchase in
                    NavigationLink(destination: PurchaseDetailsView(purchase: purchase)) {
                        PurchaseRowView(purchase: purchase)
                    }
                }
                .onDelete(){
                    indexSet in
                    purchaseViewModel.removePurchases(atOffsets: indexSet)
                }
            }.navigationTitle("Purchases")
                .navigationBarItems(trailing: addButton {
                    self.presentAddPurchaseSheet.toggle()
            })
             .onAppear() {
                 purchaseViewModel.subscribe()
            }
             .sheet(isPresented: self.$presentAddPurchaseSheet){
                 let purchase = PurchaseB(name: "", ida: "", pieces: "")
                 PurchaseEditView(viewModel: PurchaseViewModel(purchase: purchase), mode: .new) { result in
                     if case .success(let action) = result, action == .delete {
                         self.presentationMode.wrappedValue.dismiss()
                     }
                 }
             }
        }
        
    }
}

struct PurchasesListView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasesListView()
    }
}
