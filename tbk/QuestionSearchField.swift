import SwiftUI
import UIKit
import Combine
import Logging


/// 我的文本编辑器
/// copy from dist: https://gist.github.com/unnamedd/9346e1b0205ed6e2d09bf4709229a029
struct QuestionSearchField: UIViewRepresentable {
    @Binding var text: String

    static var logger = Logger(label: "QueryQ")

    var viewModel: QuestionQueryObserved

    func makeUIView(context: Context) -> UISearchTextField {
        let textField = UISearchTextField()
        textField.delegate = context.coordinator
        textField.returnKeyType = .search
        textField.placeholder = "请输入您要查询的内容"

        NotificationCenter.default.addObserver(
            forName: UISearchTextField.textDidChangeNotification,
            object: textField,
            queue: OperationQueue.main) { (notification) in
            self.text = textField.text ?? ""
        }

        return textField
    }

    func updateUIView(_ uiView: UISearchTextField, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UISearchTextFieldDelegate {
        var parent: QuestionSearchField

        init(_ textField: QuestionSearchField) {
            self.parent = textField
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            let q = textField.text ?? ""
            if q == "" {
                logger.error("no query content")
                return false
            }

            logger.info("query content: \(q)")

            self.parent.text = q
            DispatchQueue.main.async {
                self.parent.viewModel.doQuery(q: q)
            }

            return true
        }
    }
}


