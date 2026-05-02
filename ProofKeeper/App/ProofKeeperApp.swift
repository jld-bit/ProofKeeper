import SwiftUI
import SwiftData

@main
struct ProofKeeperApp: App {
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .modelContainer(for: [Purchase.self, ReminderRule.self])
        }
    }
}
