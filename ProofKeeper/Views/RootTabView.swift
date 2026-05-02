import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem { Label("Dashboard", systemImage: "chart.pie") }

            PurchasesListView()
                .tabItem { Label("Purchases", systemImage: "list.bullet.rectangle") }

            PremiumView()
                .tabItem { Label("Premium", systemImage: "star.circle") }
        }
    }
}

#Preview {
    RootTabView()
}
