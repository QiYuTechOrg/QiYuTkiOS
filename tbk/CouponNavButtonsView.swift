import Foundation
import SwiftUI

/// home 按钮 界面
///
/// 平分 宽度
///
/// https://stackoverflow.com/questions/56620499/equal-widths-of-subviews-with-swiftui
struct CouponNavButtonsView: View {

    let iconSize: CGFloat = 64

    @Environment(\.colorScheme) var colorScheme

    func makeIcon(text: String) -> AnyView {
        if (colorScheme == .dark) {
            return AnyView(
                Image(text).resizable().frame(width: iconSize, height: iconSize)
                    .overlay(RoundedRectangle(cornerRadius: iconSize / 2).stroke(color_dark_overlay_border_default, lineWidth: 1)))
        } else {
            return AnyView(Image(text).resizable().frame(width: iconSize, height: iconSize))
        }
    }


    var body: some View {
        HStack(spacing: 5) {
            NavigationLink(destination: TbkAllCategory().navigationBarTitle("全部分类", displayMode: .inline)) {
                self.makeIcon(text: "coupon_category_all")
            }.buttonStyle(PlainButtonStyle()).frame(maxWidth: .infinity)

            NavigationLink(destination: TbkFastBuyContentView().navigationBarTitle("快抢商品", displayMode: .inline)) {
                self.makeIcon(text: "coupon_category_fast")
            }.buttonStyle(PlainButtonStyle()).frame(maxWidth: .infinity)

            NavigationLink(destination: TbkRecommendContentView().navigationBarTitle("热销推荐", displayMode: .inline)) {
                self.makeIcon(text: "coupon_category_recommend")
            }.buttonStyle(PlainButtonStyle()).frame(maxWidth: .infinity)

            NavigationLink(destination: TbkBrandListContentView().navigationBarTitle("超值大牌", displayMode: .inline)) {
                self.makeIcon(text: "coupon_category_big")
            }.buttonStyle(PlainButtonStyle()).frame(maxWidth: .infinity)

            NavigationLink(destination: TbkNineNineContentView().navigationBarTitle("9.9包邮购", displayMode: .inline)) {
                self.makeIcon(text: "coupon_category_99")
            }.buttonStyle(PlainButtonStyle()).frame(maxWidth: .infinity)

        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}
