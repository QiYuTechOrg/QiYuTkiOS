import Foundation
import SwiftUI

let app_const_name: String = "奇遇淘客"
let app_const_tip: String = "奇遇淘客"
let app_const_alert: String = "奇遇淘客提示您"

let color_goldenrod = Color(red: 218 / 255.0, green: 165 / 255.0, blue: 32 / 255.0)
// 深红色的背景
let color_dark_red = Color(red: 254 / 255.0, green: 210 / 255.0, blue: 209 / 255.0)
// 浅红色的背景
let color_light_red = Color(red: 249 / 255.0, green: 233 / 255.0, blue: 230 / 255.0)
// 红色的文字
let color_text_red = Color(red: 240 / 255.0, green: 27 / 255.0, blue: 26 / 255.0)
// 灰色的文字
let color_text_gray = Color(red: 128 / 255.0, green: 128 / 255.0, blue: 128 / 255.0)

// 灰色的文字
let color_dark_text_default = Color(red: 165 / 255.0, green: 158 / 255.0, blue: 146 / 255.0)

class MyColorUtils {
    /// 获取默认的文字颜色
    static func getTextDefaultColor(scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return Color(red: 232 / 255.0, green: 230 / 255.0, blue: 227 / 255.0)
        }
        return Color.black
    }

    static func getTextGrayColor(scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return Color(red: 168 / 255.0, green: 160 / 255.0, blue: 149 / 255.0)
        }
        return Color(red: 102 / 255.0, green: 102 / 255.0, blue: 102 / 255.0)
    }

    static func getLightRedColor(scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return Color(red: 56 / 255.0, green: 20 / 255.0, blue: 13 / 255.0)
        }
        return Color(red: 249 / 255.0, green: 233 / 255.0, blue: 230 / 255.0)
    }

    static func getDarkRedColor(scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return Color(red: 78 / 255.0, green: 3 / 255.0, blue: 2 / 255.0)
        }
        return Color(red: 254 / 255.0, green: 210 / 255.0, blue: 209 / 255.0)
    }

    static func getDefaultRedColor(scheme: ColorScheme) -> Color {
        if scheme == .dark {
            return Color(red: 241 / 255.0, green: 48 / 255.0, blue: 47 / 255.0)
        }
        return Color(red: 240 / 255.0, green: 27 / 255.0, blue: 26 / 255.0)
    }
}

// 灰色的文字
// 黑暗模式圆圈 border 的颜色
let color_dark_overlay_border_default = Color(red: 221 / 255.0, green: 218 / 255.0, blue: 213 / 255.0)
