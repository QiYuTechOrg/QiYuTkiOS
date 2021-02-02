import Logging
import SwiftUI


/// 公告信息
struct HomeAnnouncementView: View {

    var logger = Logging.Logger(label: "公告信息")

    @State var title = "公告信息已移除..."
    @State var url: URL? = nil

    var body: some View {
        Text(title)
    }
}

#if DEBUG
struct HomeAnnouncement_Previews: PreviewProvider {
    static var previews: some View {
        HomeAnnouncementView()
    }
}
#endif
