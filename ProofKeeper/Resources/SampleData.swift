import Foundation
import SwiftData

enum SampleData {
    @MainActor
    static var previewContainer: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Purchase.self, ReminderRule.self, configurations: config)

        let samples: [Purchase] = [
            Purchase(productName: "Aurora Noisebuds", store: "Skyline Audio", category: .electronics, purchaseDate: .now.addingTimeInterval(-86_400 * 120), price: 129.99, warrantyEndDate: .now.addingTimeInterval(86_400 * 245), notes: "Gift receipt saved."),
            Purchase(productName: "Terra Blender", store: "Home Harbor", category: .appliances, purchaseDate: .now.addingTimeInterval(-86_400 * 400), price: 89.00, warrantyEndDate: .now.addingTimeInterval(-86_400 * 35), notes: "Motor replaced once."),
            Purchase(productName: "TrailLite Jacket", store: "Peak Thread Co.", category: .fashion, purchaseDate: .now.addingTimeInterval(-86_400 * 330), price: 140.00, warrantyEndDate: .now.addingTimeInterval(86_400 * 18), notes: "Waterproof seam warranty.")
        ]

        samples.forEach { container.mainContext.insert($0) }
        return container
    }
}
