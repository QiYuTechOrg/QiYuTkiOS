import Foundation
import SwiftUI

/// 商品搜索页面
struct ShopSearchContentView: View {

    @ObservedObject var hotWords = HotWordsDataObserved.shared

    @ObservedObject var user = AppUserSettings.shared

    @State var searchString = ""

    @State var openSearchDetailPage = false

    // iOS sucks :(
    // https://stackoverflow.com/questions/56513568/ios-swiftui-pop-or-dismiss-view-programmatically
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(spacing: 10) {
                Spacer().frame(width: 10)
                MySearchField(text: $searchString, openSearchPage: $openSearchDetailPage)
                Button("取消") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer().frame(width: 10)
            }.frame(height: 30)

            Text("历史搜索").font(.system(size: 25))

            GeometryReader { geometry in
                self.generateSearchHistoryContent(in: geometry)
                Spacer()
            }.frame(maxHeight: 120)

            Text("热门搜索").font(.system(size: 25))

            GeometryReader { geometry in
                self.generateHotKeywordContent(in: geometry)
                Spacer()
            }.frame(maxHeight: 120)

            Spacer()
        }
            .sheet(isPresented: $openSearchDetailPage, content: {
                ShopSearchDetailContentView(q: self.searchString)
            })

        // navigation link
        //NavigationLink(destination: ShopSearchDetailContentView(q: self.searchString).navigationBarTitle("").navigationBarHidden(true), isActive: $openSearchDetailPage) {
        //    EmptyView()
        //}
        // onAppear is good for other init
        // .onAppear {
        //    self.hotWords.loadData()
        // }
    }

    private func generateSearchHistoryContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.user.itemSearchHistory, id: \.self) { query in
                self.item(for: query)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if query == self.user.itemSearchHistory.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if query == self.user.itemSearchHistory.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }


    private func generateHotKeywordContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.hotWords.hotWords, id: \.self) { hotWord in
                self.item(for: hotWord)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if hotWord == self.hotWords.hotWords.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if hotWord == self.hotWords.hotWords.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }


    private func item(for text: String) -> some View {
        Button(text) {
            // add to search history
            self.user.addSearchHistory(q: text)

            self.searchString = text
            self.openSearchDetailPage = true
        }
            .padding(.all, 5)
    }
}

