//
//  AdminOrder.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 15/12/24.
//

import SwiftUI

struct AdminOrder: View {
    @EnvironmentObject var orderViewModel: OrderViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
               

                Divider()

                // Orders List
                List {
                    Section(header: Text("Orders").font(.headline)) {
                        if orderViewModel.orders.isEmpty {
                            Text("No orders found.")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding()
                        } else {
                            ForEach(orderViewModel.orders) { order in
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Total: RM \(order.total, specifier: "%.2f")")
                                            .font(.headline)
                                        Text("Payment: \(order.paymentMethod)")
                                            .font(.subheadline)
                                        Text("Address: \(order.address)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }

                                    Spacer()

                                    HStack(spacing: 10) {
                                        Button(action: {
                                            // Kosong: Update order
                                        }) {
                                            Text("Update")
                                                .foregroundColor(.blue)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 12)
                                                .background(Color.blue.opacity(0.1))
                                                .cornerRadius(8)
                                        }

                                        Button(action: {
                                            // Kosong: Delete order
                                        }) {
                                            Text("Delete")
                                                .foregroundColor(.red)
                                                .padding(.vertical, 8)
                                                .padding(.horizontal, 12)
                                                .background(Color.red.opacity(0.1))
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())

                // Add Order Button
                Button("Add Order") {
                    // Kosong: Add order
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                .padding()
            }
            .navigationTitle("Orders Management")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                orderViewModel.fetchOrders { orders, error in
                    if let error = error {
                        print("Error fetching orders: \(error.localizedDescription)")
                    } else {
                        print("Orders fetched successfully.")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Menyesuaikan untuk iPad
    }
}





//import SwiftUI
//
//
//
//struct AdminOrder: View {
//    @EnvironmentObject var orderViewModel: OrderViewModel
//
//    var body: some View {
//        NavigationView {
//            List {
//                if orderViewModel.orders.isEmpty {
//                    Text("No orders found.")
//                        .foregroundColor(.gray)
//                } else {
//                    ForEach(orderViewModel.orders) { order in
//                        NavigationLink(destination: OrderDetailView(order: order)) {
//                            VStack(alignment: .leading) {
//                                Text("Total: RM \(order.total, specifier: "%.2f")")
//                                    .font(.headline)
//                                Text("Payment: \(order.paymentMethod)")
//                                    .font(.subheadline)
//                                Text("Address: \(order.address)")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Order History")
//            .onAppear {
//                orderViewModel.fetchOrders { orders, error in
//                    if let error = error {
//                        print("Error fetching orders: \(error.localizedDescription)")
//                    } else {
//                        // Data berhasil diambil, orders sudah tersedia
//                        print("Orders fetched successfully")
//                    }
//                }
//            }
//        }
//        .navigationBarHidden(true)
//    }
//}
