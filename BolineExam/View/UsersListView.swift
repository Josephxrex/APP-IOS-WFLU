//
//  UsersListView.swift
//  BolineExam
//
//  Created by ISSC_611_2023 on 18/05/23.
//

import SwiftUI

var userViewModel = UsersViewModel()

struct UsersListView: View {
    var body: some View {
        NavigationView(
            List{
                ForEach(userViewModel.users) {
                    user in NavigationLink(destination: UserDetailView(user: user)){
                        //ProductRowView(user:user)
                    }
                }
            }
        )
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
