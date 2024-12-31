//
//  HistoryView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 10/12/24.
//

import SwiftUI



struct HistoryView: View {
    @EnvironmentObject var orderViewModel: OrderViewModel

    var body: some View {
        NavigationView {
            List {
                if orderViewModel.orders.isEmpty {
                    Text("No orders found.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(orderViewModel.orders) { order in
                        NavigationLink(destination: OrderDetailView(order: order)) {
                            VStack(alignment: .leading) {
                                
//                                ForEach(order.items) { item in
//                                    Image(item.product.ImgProduct)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 130, height: 130)
//                                        .cornerRadius(15)
//                                }
                                
                                Text("Total: RM \(order.total, specifier: "%.2f")")
                                    .font(.headline)
                                Text("Payment: \(order.paymentMethod)")
                                    .font(.subheadline)
                                Text("Address: \(order.address)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Order History")
            .onAppear {
                orderViewModel.fetchOrders { orders, error in
                    if let error = error {
                        print("Error fetching orders: \(error.localizedDescription)")
                    } else {
                        // Data berhasil diambil, orders sudah tersedia
                        print("Orders fetched successfully")
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}




//struct HistoryView: View {
//    @EnvironmentObject var orderViewModel: OrderViewModel
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(orderViewModel.orders) { order in
//                    NavigationLink(destination: OrderDetailView(order: order)) {
//                        VStack(alignment: .leading) {
//                            Text("Total: RM \(order.total, specifier: "%.2f")")
//                                .font(.headline)
//                            Text("Payment: \(order.paymentMethod)")
//                                .font(.subheadline)
//                            Text("Address: \(order.address)")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Order History")
//        }
//    }
//}

#Preview {
    HistoryView()
}
