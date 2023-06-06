import Foundation
import SwiftUI

struct Component_DetailField: View {
    @State var textTitle: String
    @State var textValue: String
    
    var body: some View {
        HStack {
            Text(textTitle).bold()
            Text(textValue)
        }
    }
}

