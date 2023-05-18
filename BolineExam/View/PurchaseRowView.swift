//
//  PurchaseRowView.swift
//  BolineExam
//
//  Created by ISSC_611_2023 on 18/05/23.
//

import SwiftUI



struct PurchaseRowView: View {
    var purchase: PurchaseB
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 40, height: 40).padding(10)
            VStack(alignment: .leading){
                Text(purchase.name).font(.title)
                HStack{
                    Text("idP:"+purchase.idP).font(.subheadline)
                    Text("Pieces:"+purchase.pieces).font(.subheadline)
                    
                }
            }
        }
    }
}

struct PurchaseRowView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseRowView(purchase: PurchaseB(name: "prueba", idP: "63", pieces: "32"))
            .previewLayout(
                .fixed(width: 400, height: 60))
    }
}

