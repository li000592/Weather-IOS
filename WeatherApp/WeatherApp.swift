import SwiftUI
// import GoogleMobileAds  // 注释掉广告SDK导入

@main
struct WeatherApp: App {
    init() {
        // 注释掉广告初始化代码
        /*
        GADMobileAds.sharedInstance().start { status in
            print("Google Mobile Ads SDK 初始化状态: \(status.description)")
        }
        */
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
