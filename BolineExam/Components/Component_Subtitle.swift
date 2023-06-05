import SwiftUI

struct Component_Subtitle: View {
    @State public var subtitleText: String
    
    var body: some View {
        Text(subtitleText).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.white).padding(.horizontal)
    }
}
