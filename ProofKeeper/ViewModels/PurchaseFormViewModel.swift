import Foundation
import SwiftData

@MainActor
final class PurchaseFormViewModel: ObservableObject {
    @Published var productName = ""
    @Published var store = ""
    @Published var category: PurchaseCategory = .electronics
    @Published var purchaseDate = Date()
    @Published var price = ""
    @Published var warrantyEndDate = Calendar.current.date(byAdding: .year, value: 1, to: .now) ?? .now
    @Published var notes = ""
    @Published var selectedReminderOffsets = [30, 7, 1]

    func save(context: ModelContext, receiptPhotoData: Data?) throws {
        let parsedPrice = Double(price) ?? 0
        let purchase = Purchase(
            productName: productName,
            store: store,
            category: category,
            purchaseDate: purchaseDate,
            price: parsedPrice,
            warrantyEndDate: warrantyEndDate,
            receiptPhotoData: receiptPhotoData,
            notes: notes
        )
        context.insert(purchase)

        for offset in selectedReminderOffsets {
            context.insert(ReminderRule(purchaseID: purchase.id, daysBefore: offset))
        }

        try context.save()
    }
}
