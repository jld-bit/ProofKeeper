import Foundation
import SwiftData

@Model
final class ReminderRule {
    var id: UUID
    var purchaseID: UUID
    var daysBefore: Int
    var isEnabled: Bool

    init(id: UUID = UUID(), purchaseID: UUID, daysBefore: Int, isEnabled: Bool = true) {
        self.id = id
        self.purchaseID = purchaseID
        self.daysBefore = daysBefore
        self.isEnabled = isEnabled
    }
}
