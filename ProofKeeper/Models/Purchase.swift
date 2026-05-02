import Foundation
import SwiftData

@Model
final class Purchase {
    var id: UUID
    var productName: String
    var store: String
    var category: PurchaseCategory
    var purchaseDate: Date
    var price: Double
    var warrantyEndDate: Date
    @Attribute(.externalStorage) var receiptPhotoData: Data?
    var notes: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        productName: String,
        store: String,
        category: PurchaseCategory,
        purchaseDate: Date,
        price: Double,
        warrantyEndDate: Date,
        receiptPhotoData: Data? = nil,
        notes: String = "",
        createdAt: Date = .now
    ) {
        self.id = id
        self.productName = productName
        self.store = store
        self.category = category
        self.purchaseDate = purchaseDate
        self.price = price
        self.warrantyEndDate = warrantyEndDate
        self.receiptPhotoData = receiptPhotoData
        self.notes = notes
        self.createdAt = createdAt
    }
}

enum PurchaseCategory: String, CaseIterable, Codable, Identifiable {
    case electronics
    case appliances
    case furniture
    case sports
    case fashion
    case other

    var id: String { rawValue }

    var title: String {
        switch self {
        case .electronics: "Electronics"
        case .appliances: "Appliances"
        case .furniture: "Furniture"
        case .sports: "Sports"
        case .fashion: "Fashion"
        case .other: "Other"
        }
    }
}
