import SwiftUI

import Logging


// 微信群
struct GroupContentView: View {

    @State private var login = AppUserSettings.checkLogin()

    var body: some View {
        VStack {
            HomeHeaderView("微信群").frame(height: 80)

            Text("您的内容").font(.largeTitle)

        }.edgesIgnoringSafeArea([.top])
    }
}

#if DEBUG
struct GroupContentView_Previews: PreviewProvider {
    static var previews: some View {
        GroupContentView()
    }
}
#endif
