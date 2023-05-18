import SwiftUI

var userViewModel = UsersViewModel()

struct UsersListView: View {
    var body: some View {
        NavigationView{
            List{
                ForEach(userViewModel.users) {
                    user in NavigationLink(destination: UserDetailView(user: user)){
                        UserRowView(user:user)
                    }
                }
                .onDelete(){
                    indexSet in userViewModel.removeUsers(atOffsets: indexSet)
                }
            }.onAppear(){
                    userViewModel.subscribe()
                }
        }.navigationTitle("Users")
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
