import SwiftUI

struct UserRowView: View {
    var user: UserB
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 40, height: 40).padding(10)
            VStack(alignment: .leading){
                Text(user.name).font(.title)
                HStack{
                    Text("Name:"+user.name).font(.subheadline)
                    Text("Lastname:"+user.lastname).font(.subheadline)
                }
            }
        }
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: UserB(name: "", lastname: "", age: "", gender: "", emial: "", password: ""))
            .previewLayout(
                .fixed(width: 400, height: 60))
    }
}
