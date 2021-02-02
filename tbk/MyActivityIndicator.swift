import Foundation
import SwiftUI


/// 我的活动指示器
struct MyActivityIndicator: UIViewRepresentable {

    let style: UIActivityIndicatorView.Style = .large

    func makeUIView(context: UIViewRepresentableContext<MyActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<MyActivityIndicator>) {
        uiView.startAnimating()
    }
}

#if DEBUG
struct MyActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        MyActivityIndicator()
    }
}
#endif
