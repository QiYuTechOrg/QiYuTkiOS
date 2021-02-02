import SwiftUI

// 共享的 AlertMsg 处理
enum SharedAlertMsg: Identifiable {
    case tip(s: String)

    var id: Int {
        switch self {
        case .tip(s: let s): return s.hashValue
        }
    }
}

func shared_alert_msg(msg: SharedAlertMsg) -> Alert {
    switch msg {
    case .tip(s: let s):
        return Alert(
            title: Text("奇遇淘客提示您"),
            message: Text(s),
            dismissButton: .default(Text("确认")))
    }
}

// 共享的 actionSheet 信息
enum SharedActionSheetMsg: Identifiable {
    case tip(s: String)

    var id: Int {
        switch self {
        case .tip(s: let s): return s.hashValue
        }
    }
}

func shared_action_sheet_msg(msg: SharedActionSheetMsg) -> ActionSheet {
    switch msg {
    case .tip(s: let s):
        return ActionSheet(
            title: Text("奇遇淘客提示您"),
            message: Text(s),
            buttons: [.default(Text("确认"))])
    }
}


func in_test_env() -> Bool {
    #if DEBUG
    return true
    #else
    return false
    #endif
}
