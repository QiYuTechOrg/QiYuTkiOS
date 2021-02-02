import SwiftUI

/// 我的订单页面
struct OrderContentView: View {

    var body: some View {
        TabView {
            Text("商城订单")
                .tabItem {
                    Image(systemName: "cart.circle")
                    Text("商城订单")
                }

            Text("推广订单")
                .tabItem {
                    Image(systemName: "yensign.circle")
                    Text("推广订单")
                }

            TbkOrderContentView()
                .tabItem {
                    Image(systemName: "bag.circle")
                    Text("淘客订单")
                }
        }
    }
}

#if DEBUG
struct OrderContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderContentView()
    }
}

#endif
