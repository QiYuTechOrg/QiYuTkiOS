import SwiftUI
import Logging


enum HomeTabSelectType {
    case home
    case group
    case coupon
    case me
}

// 主界面
struct ContentView: View {
    @State private var tabSelected = HomeTabSelectType.home

    // Root 中隐藏 hideBar 但是在子页面中打开
    // https://stackoverflow.com/questions/60996266/swiftui-show-hide-title-issues-with-navigationbar
    // @State private var hideBar = true // << track hide state, and default

    @State var showPrivacy = !AppUserSettings.shared.agreePrivacy

    var body: some View {
        NavigationView {
            TabView(selection: $tabSelected) {
                HomeContentView()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("主页")
                    }
                    .tag(HomeTabSelectType.home)

                GroupContentView()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("微信群")
                    }
                    .tag(HomeTabSelectType.group)

                // navigation bar will occupy some space
                // 导航也会占据一些空间
                CouponContentView()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "cart.fill.badge.minus")
                        Text("优惠券")
                    }
                    .tag(HomeTabSelectType.coupon)

                MeContentMainView()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("我的")
                    }
                    .tag(HomeTabSelectType.me)
            }
        }
            .sheet(isPresented: $showPrivacy) {
                PrivacyContentView(showThis: self.$showPrivacy, showButtons: true)
            }
            .onAppear {
                // 不允许 关闭 modal/sheet 界面
                // https://stackoverflow.com/questions/26667009/get-top-most-uiviewcontroller
                let keyWindow = UIApplication.shared.windows.filter {
                    $0.isKeyWindow
                }.first

                if var topController = keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }

                    // 不允许关闭 sheet
                    topController.isModalInPresentation = true
                }
            }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

// Hide navigation bar without losing swipe back gesture in SwiftUI
//
// 左滑返回
// copy from:
// https://stackoverflow.com/questions/59921239/hide-navigation-bar-without-losing-swipe-back-gesture-in-swiftui
//
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}


/// current useless
extension View {
    public func currentDeviceNavigationViewStyle() -> AnyView {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return AnyView(self.navigationViewStyle(DefaultNavigationViewStyle()))
        } else {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        }
    }
}
