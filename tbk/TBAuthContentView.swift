import SwiftUI

/**
 * 淘宝授权的页面
 */
struct TBAuthContentView: View {
    let url: String

    var body: some View {
        Text("demo")
    }
}

#if DEBUG
struct TBAuthContentView_Previews: PreviewProvider {
    static var previews: some View {
        TBAuthContentView(url: "")
    }
}
#endif
