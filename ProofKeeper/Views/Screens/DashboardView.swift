import SwiftUI
import SwiftData

struct DashboardView: View {
    @Query(sort: \Purchase.warrantyEndDate) private var purchases: [Purchase]
    @StateObject private var vm = DashboardViewModel()

    var summary: DashboardSummary { vm.summary(for: purchases) }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    header
                    HStack {
                        metricCard("Active", value: summary.active, color: .green)
                        metricCard("Soon", value: summary.expiringSoon, color: .orange)
                        metricCard("Expired", value: summary.expired, color: .red)
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Warranty Snapshot")
                            .font(.headline)
                        ChartBar(label: "Active", value: summary.active, color: .green)
                        ChartBar(label: "Soon", value: summary.expiringSoon, color: .orange)
                        ChartBar(label: "Expired", value: summary.expired, color: .red)
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("ProofKeeper")
            .background(
                LinearGradient(colors: [Color.blue.opacity(0.2), Color.green.opacity(0.15)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            )
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Keep your proofs, protect your purchases")
                .font(.title2.bold())
            Text("Original workflow designed for easy warranty tracking.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    private func metricCard(_ title: String, value: Int, color: Color) -> some View {
        VStack(alignment: .leading) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text("\(value)").font(.title2.bold())
            StatusBadge(label: title, color: color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
    }
}

struct ChartBar: View {
    let label: String
    let value: Int
    let color: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.caption)
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.gradient)
                    .frame(width: max(6, geo.size.width * CGFloat(min(1, Double(value) / 10.0))))
            }
            .frame(height: 16)
        }
        .frame(height: 36)
    }
}

#Preview {
    DashboardView()
        .modelContainer(SampleData.previewContainer)
}
