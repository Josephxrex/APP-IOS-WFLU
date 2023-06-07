import SwiftUI

struct UserRowView: View {
    var user: UserB
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 40, height: 40).padding(10)
                .foregroundColor(Color("Iconos"))
            VStack(alignment: .leading){
                Text(user.name).font(.title)
                HStack{
                    Text("Name:"+user.name).font(.subheadline)
                    Text("Last name:"+user.lastname).font(.subheadline)
                }
            }.foregroundColor(Color.white)
        }
    }
}
