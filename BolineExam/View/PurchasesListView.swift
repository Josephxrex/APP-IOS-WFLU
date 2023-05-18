//
//  PurchasesListView.swift
//  BolineExam
//
//  Created by ISSC_611_2023 on 18/05/23.
//

import SwiftUI

struct PurchasesListView: View {
    @StateObject var purchaseViewModel = PurchaseViewModels()
    
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
             .onAppear() {
                 purchaseViewModel.subscribe()
            }
        }
        
    }
}

struct PurchasesListView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasesListView()
    }
}
