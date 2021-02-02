import SwiftUI

// 淘宝客订单
struct TbkOrderContentView: View {
    @State var order_type: WebViewOrderType = .all

    let s_frame: CGFloat = 50
    let l_frame: CGFloat = 75

    let f_h: CGFloat = 50;

    let space: CGFloat = 20

    func header() -> some View {
        HStack(spacing: space) {
            Spacer().frame(width: 5)
            getAll()
            getDoing()
            getDone()
            Spacer()
        }.frame(height: f_h)
    }

    func getWebView() -> AnyView {
        switch order_type {
        case .all:
            return AnyView(Text("全部订单"))
        case .doing:
            return AnyView(Text("未完成"))
        case .done:
            return AnyView(Text("已完成"))
        }
    }

    var body: some View {
        VStack {
            header()

            VStack {
                getWebView()
                Spacer()
            }
        }
    }

    func getAll() -> AnyView {
        if (self.order_type == .all) {
            return AnyView(VStack {
                Text("全部").foregroundColor(Color.red)
                Divider().background(Color.red)
                Spacer()
            }.frame(width: s_frame))
        }

        return AnyView(
            VStack {
                Text("全部")
                Spacer()
            }.frame(width: s_frame).onTapGesture {
                self.order_type = .all
            })
    }

    func getDoing() -> AnyView {
        let text = "未完成"

        if (self.order_type == .doing) {
            return AnyView(VStack {
                Text(text).foregroundColor(Color.red)
                Divider().background(Color.red)
                Spacer()
            }.frame(width: l_frame))
        } else {
            return AnyView(VStack {
                Text(text)
                Spacer()
            }.frame(width: l_frame).onTapGesture {
                self.order_type = .doing
            })
        }
    }

    func getDone() -> AnyView {
        let text = "已完成"

        if (self.order_type == .done) {
            return AnyView(VStack {
                Text(text).foregroundColor(Color.red)
                Divider().background(Color.red)
                Spacer()
            }.frame(width: 75))
        } else {
            return AnyView(VStack {
                Text(text)
                Spacer()
            }.frame(width: l_frame).onTapGesture {
                self.order_type = .done
            });
        }
    }
}

#if DEBUG
struct TbkOrderContentView_Previews: PreviewProvider {
    static var previews: some View {
        TbkOrderContentView()
    }
}
#endif
