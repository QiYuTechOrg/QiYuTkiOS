import SwiftUI
import UIKit
import Combine


/// 我的文本编辑器
/// copy from dist: https://gist.github.com/unnamedd/9346e1b0205ed6e2d09bf4709229a029
struct MySearchField: UIViewRepresentable {
    @Binding var text: String

    @Binding var openSearchPage: Bool

    var allowEdit: Bool = true

    var showKeyboard: Bool = false

    func makeUIView(context: Context) -> UISearchTextField {
        let textField = UISearchTextField()
        textField.delegate = context.coordinator
        textField.returnKeyType = .search
        textField.placeholder = "搜商品/宝贝标题"

        NotificationCenter.default.addObserver(
            forName: UISearchTextField.textDidChangeNotification,
            object: textField,
            queue: OperationQueue.main) { (notification) in
            self.text = textField.text ?? ""
        }

        return textField
    }

    func updateUIView(_ uiView: UISearchTextField, context: Context) {
        if showKeyboard {
            uiView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UISearchTextFieldDelegate {
        var parent: MySearchField

        init(_ textField: MySearchField) {
            self.parent = textField
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            let q = textField.text ?? ""
            if q == "" {
                return false
            }

            AppUserSettings.shared.addSearchHistory(q: q)
            self.parent.text = q
            self.parent.openSearchPage = true

            return true
        }

        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return self.parent.allowEdit
        }
    }
}


