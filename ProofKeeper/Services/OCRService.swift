import Foundation

protocol OCRServiceProtocol {
    func parseReceipt(from data: Data) async throws -> OCRReceiptExtraction
}

struct OCRReceiptExtraction {
    let productName: String?
    let store: String?
    let purchaseDate: Date?
    let totalPrice: Double?
}

final class OCRServicePlaceholder: OCRServiceProtocol {
    func parseReceipt(from data: Data) async throws -> OCRReceiptExtraction {
        // Placeholder for future Vision / third-party OCR integration.
        OCRReceiptExtraction(productName: nil, store: nil, purchaseDate: nil, totalPrice: nil)
    }
}
