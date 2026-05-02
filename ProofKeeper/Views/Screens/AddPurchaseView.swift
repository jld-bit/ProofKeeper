import PhotosUI
import SwiftUI
import SwiftData

struct AddPurchaseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var vm = PurchaseFormViewModel()

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var receiptPhotoData: Data?

    var body: some View {
        NavigationStack {
            Form {
                TextField("Product name", text: $vm.productName)
                TextField("Store", text: $vm.store)
                Picker("Category", selection: $vm.category) {
                    ForEach(PurchaseCategory.allCases) { category in
                        Text(category.title).tag(category)
                    }
                }
                DatePicker("Purchase date", selection: $vm.purchaseDate, displayedComponents: .date)
                TextField("Price", text: $vm.price)
                    .keyboardType(.decimalPad)
                DatePicker("Warranty end", selection: $vm.warrantyEndDate, displayedComponents: .date)
                TextField("Notes", text: $vm.notes, axis: .vertical)

                Section("Receipt Photo") {
                    PhotosPicker("Select receipt image", selection: $selectedPhoto, matching: .images)
                }

                Section("Reminder timing") {
                    ReminderToggleRow(title: "30 days before", offset: 30, selectedOffsets: $vm.selectedReminderOffsets)
                    ReminderToggleRow(title: "7 days before", offset: 7, selectedOffsets: $vm.selectedReminderOffsets)
                    ReminderToggleRow(title: "1 day before", offset: 1, selectedOffsets: $vm.selectedReminderOffsets)
                }
            }
            .task(id: selectedPhoto) {
                receiptPhotoData = try? await selectedPhoto?.loadTransferable(type: Data.self)
            }
            .navigationTitle("New Purchase")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        try? vm.save(context: modelContext, receiptPhotoData: receiptPhotoData)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ReminderToggleRow: View {
    let title: String
    let offset: Int
    @Binding var selectedOffsets: [Int]

    var body: some View {
        Toggle(title, isOn: Binding(
            get: { selectedOffsets.contains(offset) },
            set: { enabled in
                if enabled {
                    selectedOffsets.append(offset)
                } else {
                    selectedOffsets.removeAll(where: { $0 == offset })
                }
            }
        ))
    }
}
