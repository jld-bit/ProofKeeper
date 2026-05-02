import Foundation
import StoreKit

@MainActor
final class SubscriptionService: ObservableObject {
    @Published var hasPremium = false

    private let premiumProductID = "com.proofkeeper.premium.monthly"

    func refreshEntitlementStatus() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            if transaction.productID == premiumProductID {
                hasPremium = true
                return
            }
        }
        hasPremium = false
    }

    func purchasePremium() async throws {
        guard let product = try await Product.products(for: [premiumProductID]).first else { return }
        let result = try await product.purchase()
        if case .success(let verificationResult) = result,
           case .verified = verificationResult {
            hasPremium = true
        }
    }
}
