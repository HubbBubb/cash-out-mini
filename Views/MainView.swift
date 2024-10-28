//
//  MainView.swift
//  Cash Out mini
//
//  Created by Gergo Huber on 2024. 10. 26..
//
import SwiftUI

struct MainView: View {
    @State private var isAddExpenseViewPresented = false
    @State private var isUserLoggedIn = false
    @State private var userName: String? = nil
    @State private var isLoginViewPresented = false
    @StateObject private var expenseManager = ExpenseManager()

    var body: some View {
        VStack {
            if let userName = userName, isUserLoggedIn {
                Text("Hello, \(userName)!")
                    .font(.headline)
                    .padding()
            }
            TabView {
                NavigationView {
                    ExpenseListView(expenseManager: expenseManager)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Image("Logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 30)
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    isLoginViewPresented = true
                                }) {
                                    Image(systemName: "person.circle")
                                        .font(.title)
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    isAddExpenseViewPresented = true
                                }) {
                                    Image(systemName: "plus")
                                }
                            }
                        }
                        .sheet(isPresented: $isLoginViewPresented) {
                            LoginView(isUserLoggedIn: $isUserLoggedIn, userName: $userName)
                        }
                        .sheet(isPresented: $isAddExpenseViewPresented) {
                            AddExpenseView(expenseManager: expenseManager)
                        }
                }
                .tabItem {
                    Label("Expenses", systemImage: "list.bullet")
                }

                NavigationView {
                    ExpenseSummaryView(expenseManager: expenseManager)
                }
                .tabItem {
                    Label("Summary", systemImage: "chart.bar.fill")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
