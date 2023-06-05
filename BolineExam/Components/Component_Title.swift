import SwiftUI

struct Component_Title: View {
    @State public var titleText: String
    
    var body: some View {
        Text(titleText)
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white).padding(.leading)
    }
}
