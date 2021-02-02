import SwiftUI

/// 淘宝客搜索 页面
/// 这个页面仅有搜索框
/// 没有结果内容
struct TbkSearchContentView: View {
    @State var q: String = ""
    @State var navPage = false

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            HStack {
                MySearchField(text: $q, openSearchPage: $navPage, showKeyboard: true).frame(height: 36).padding()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("取消")
                })
            }
            Spacer()
            NavigationLink(destination: TbkSearchResultContentView(q: q)
                .navigationBarTitle(Text(q), displayMode: .inline),
                isActive: $navPage) {

                EmptyView()
            }
        }
    }
}

#if DEBUG
struct TbkSearchContentView_Previews: PreviewProvider {
    static var previews: some View {
        TbkSearchContentView()
    }
}
#endif
