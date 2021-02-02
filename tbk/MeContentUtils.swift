import Foundation
import SwiftUI

// 我的界面的辅助类
struct MeContentUtils {
    static public let line_height: CGFloat = 30
    static public let line_padding: CGFloat = 20
    static public let line_icon_width: CGFloat = 30

    static public func lineGen(img: Image, text: Text) -> some View {
        HStack {
            img.resizable().scaledToFit().frame(width: line_icon_width)
            text.frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "chevron.right").scaledToFit().frame(width: 20)
        }.frame(height: MeContentUtils.line_height)
    }


    static public func vStackWrapper<ContentType>(v: VStack<ContentType>) -> some View {
        v.padding()
    }

    static public func makeSpacer() -> some View {
        Spacer().frame(width: MeContentUtils.line_padding)
    }
}
