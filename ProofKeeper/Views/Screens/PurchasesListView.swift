import SwiftUI
import SwiftData

struct PurchasesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Purchase.purchaseDate, order: .reverse) private var purchases: [Purchase]

    @State private var searchText = ""
    @State private var selectedCategory: PurchaseCategory?
    @State private var showingAddForm = false

    private var filteredPurchases: [Purchase] {
        purchases.filter { purchase in
            let matchesText = searchText.isEmpty || purchase.productName.localizedCaseInsensitiveContains(searchText) || purchase.store.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == nil || purchase.category == selectedCategory
            return matchesText && matchesCategory
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredPurchases) { purchase in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(purchase.productName).font(.headline)
                        Text("\(purchase.store) · \(purchase.purchaseDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Purchases")
            .searchable(text: $searchText, prompt: "Search product or store")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Category") {
                        Button("All") { selectedCategory = nil }
                        ForEach(PurchaseCategory.allCases) { category in
                            Button(category.title) { selectedCategory = category }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddForm = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddForm) {
                AddPurchaseView()
            }
        }
    }
}

#Preview {
    PurchasesListView()
        .modelContainer(SampleData.previewContainer)
}
