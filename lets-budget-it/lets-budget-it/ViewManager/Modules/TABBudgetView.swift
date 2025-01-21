import SwiftUI

struct TABBudgetView: View {
    @State private var currentMonth: Date = Date() // Current month

    var body: some View {
        VStack(spacing: 20) {
            // Month Selector Bar
            MonthSelector(currentMonth: $currentMonth)

            // Total Budget Header
            VStack {
                Text("Total Budget")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("€0.00")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(hex: "006FFF"))
            .cornerRadius(15)
            .padding(.horizontal)

            // Budget Breakdown Section
            VStack(alignment: .leading, spacing: 15) {
                Text("Budget Breakdown")
                    .font(.headline)
                    .padding(.horizontal)
                
                VStack(spacing: 10) {
                    BudgetCategoryRow(icon: "cart.fill", color: .green, category: "Groceries", spent: "€0.00", total: "€0.00")
                    BudgetCategoryRow(icon: "bag.fill", color: .orange, category: "Shopping", spent: "€0.00", total: "€0.00")
                    BudgetCategoryRow(icon: "house.fill", color: .purple, category: "Rent", spent: "€0.00", total: "€0.00")
                    BudgetCategoryRow(icon: "car.fill", color: .red, category: "Transport", spent: "€0.00", total: "€0.00")
                }
            }

            // Manage Budget Button
            Button(action: {
                // Handle manage budget action here
            }) {
                Text("Manage Budget")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "006FFF"))
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            
            // Development Status Text
            Text("This module (Budget Management) is currently still in development.")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top, 5)
                .padding(.horizontal)

            Spacer()
        }
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
    }
}

struct MonthSelector: View {
    @Binding var currentMonth: Date

    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                }
            }) {
                Image(systemName: "chevron.left")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .clipShape(Circle())
            }

            Spacer()

            Text(currentMonthFormatted())
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()

            Button(action: {
                withAnimation {
                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                }
            }) {
                Image(systemName: "chevron.right")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }

    private func currentMonthFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy" // Example: "January 2025"
        return formatter.string(from: currentMonth)
    }
}

struct BudgetCategoryRow: View {
    let icon: String
    let color: Color
    let category: String
    let spent: String
    let total: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(10)
                .background(color)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(category)
                    .font(.headline)
                Text("\(spent) of \(total)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()

            LinearGradientProgressView(progress: 0)
                .frame(width: 100, height: 6)
                .clipShape(Capsule())
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1)) // Light gray background for the row
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }
}

struct LinearGradientProgressView: View {
    var progress: CGFloat // Progress value between 0 and 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3)) // Background track
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                         startPoint: .leading,
                                         endPoint: .trailing))
                    .frame(width: geometry.size.width * progress) // Progress bar width
            }
        }
    }
}

struct TABBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        TABBudgetView()
    }
}
