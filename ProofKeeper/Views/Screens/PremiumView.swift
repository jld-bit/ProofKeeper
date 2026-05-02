import SwiftUI

struct PremiumView: View {
    @StateObject private var subscriptionService = SubscriptionService()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Free Plan")
                    .font(.headline)
                Text("• Limited receipts\n• Basic reminders")

                Text("Premium Plan")
                    .font(.headline)
                    .padding(.top, 8)
                Text("• Unlimited receipts\n• Export tools\n• OCR-ready workflow\n• Extra reminder intervals\n• Themes")

                Button("Upgrade with StoreKit 2") {
                    Task { try? await subscriptionService.purchasePremium() }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("Premium")
        }
    }
}
