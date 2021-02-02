import Foundation
import SwiftUI

/// 奇遇淘客文字
struct HomeHeaderView: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Spacer().frame(height: geometry.safeAreaInsets.top)
            }

            Spacer()

            Text(text).foregroundColor(Color.yellow).font(.system(size: 32))

            Spacer()
        }
            .background(Color.black)
    }
}

#if DEBUG
struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView("奇遇淘客")
    }
}
#endif
