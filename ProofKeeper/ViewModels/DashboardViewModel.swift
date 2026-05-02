import Foundation

struct DashboardSummary {
    let active: Int
    let expiringSoon: Int
    let expired: Int
}

final class DashboardViewModel: ObservableObject {
    func summary(for purchases: [Purchase]) -> DashboardSummary {
        let now = Date()
        let soonDate = Calendar.current.date(byAdding: .day, value: 30, to: now) ?? now

        let expired = purchases.filter { $0.warrantyEndDate < now }.count
        let expiringSoon = purchases.filter { $0.warrantyEndDate >= now && $0.warrantyEndDate <= soonDate }.count
        let active = max(0, purchases.count - expired - expiringSoon)

        return DashboardSummary(active: active, expiringSoon: expiringSoon, expired: expired)
    }
}
