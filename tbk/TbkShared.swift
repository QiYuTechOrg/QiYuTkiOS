import Foundation

import SwiftUI


// 淘宝客共享代码
class TbkShared {

    /// 获取月销量字符串
    static func getMonthSales(monthSales: Int?) -> String {
        guard let sales = monthSales else {
            return "0"
        }

        if (sales > 10000) {
            return "\(sales / 10000)万"
        }

        return sales.description
    }

    // 获取 券 金额 UI
    static func getCouponAndPriceHStack(colorScheme: ColorScheme, price: Float?) -> AnyView {
        let width: CGFloat = 36

        return AnyView(HStack(spacing: 0) {
            Text("券").font(.callout).frame(width: width)
                .background(MyColorUtils.getDarkRedColor(scheme: colorScheme))
                .foregroundColor(MyColorUtils.getDefaultRedColor(scheme: colorScheme))
            Text(getCouponPriceText(price: price)).font(.callout).frame(width: width)
                .background(MyColorUtils.getLightRedColor(scheme: colorScheme))
                .foregroundColor(MyColorUtils.getDefaultRedColor(scheme: colorScheme))
        })
    }

    private static func getCouponPriceText(price: Float?) -> String {
        guard let c = price else {
            return "0"
        }
        let i = Int(c)
        return i.description
    }
}
