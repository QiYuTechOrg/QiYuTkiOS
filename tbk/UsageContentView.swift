import SwiftUI

/// 使用教程
struct UsageContentView: View {
    var body: some View {
        Image("usage").resizable().scaledToFit()
    }
}

#if DEBUG
struct UsageContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsageContentView()
    }
}
#endif
