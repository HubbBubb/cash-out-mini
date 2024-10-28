//
//  SwiftUIView.swift
//  Cash Out mini
//
//  Created by Gergo Huber on 2024. 10. 26..
//

import SwiftUI

struct ExpenseListView: View {
    @ObservedObject var expenseManager: ExpenseManager
    @State private var selectedExpense: Expense?

    private var groupedExpenses: [String: [Expense]] {
        Dictionary(grouping: expenseManager.expenses.sorted { $0.date < $1.date }) { expense in
            let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMMM yyyy"
            return monthFormatter.string(from: expense.date)
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedExpenses.keys.sorted(by: <), id: \.self) { month in
                    Section(header: Text(month).font(.title3).bold()) {
                        ForEach(groupedExpenses[month] ?? []) { expense in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(expense.title).font(.headline)
                                    Text("\(expense.amount, specifier: "%.2f") $").font(.subheadline)
                                }
                                Spacer()
                                Text(expense.category).font(.footnote).foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                            .onTapGesture {
                                selectedExpense = expense
                            }
                        }
                    }
                }
            }
            .sheet(item: $selectedExpense) { expense in
                ExpenseDetailView(expense: expense)
            }
            .navigationTitle("Expenses")
        }
    }
}
