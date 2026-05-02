import Foundation
import UserNotifications

final class NotificationService {
    static let shared = NotificationService()

    func requestAuthorization() async throws {
        _ = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
    }

    func scheduleWarrantyReminder(for purchase: Purchase, daysBefore: Int) async throws {
        let reminderDate = Calendar.current.date(byAdding: .day, value: -daysBefore, to: purchase.warrantyEndDate) ?? purchase.warrantyEndDate
        guard reminderDate > Date() else { return }

        let content = UNMutableNotificationContent()
        content.title = "Warranty Reminder"
        content.body = "\(purchase.productName) warranty ends in \(daysBefore) day(s)."
        content.sound = .default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "\(purchase.id.uuidString)-\(daysBefore)", content: content, trigger: trigger)

        try await UNUserNotificationCenter.current().add(request)
    }
}
