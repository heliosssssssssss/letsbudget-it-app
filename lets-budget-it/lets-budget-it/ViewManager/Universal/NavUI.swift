import SwiftUI

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // Avoid adjusting the height to prevent misalignment
        return super.sizeThatFits(size)
    }
}

struct NavUI: View {
    init() {
        // Configure the tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = UIColor.lightGray // Separator color for the tab bar

        // Apply the appearance to the tab bar
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = UIColor.systemBlue
    }

    var body: some View {
        TabView {
            TABWalletView()
                .tabItem {
                    Image(systemName: "creditcard")
                    Text("Wallet")
                }

            TABBudgetView()
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("Budget")
                }

            TABHomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            TABAnalyticsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Analytics")
                }

            TABMoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                }
        }
        .tint(.black) // Apply a consistent tint color to all tab items
    }
}

struct NavUI_Previews: PreviewProvider {
    static var previews: some View {
        NavUI()
    }
}
