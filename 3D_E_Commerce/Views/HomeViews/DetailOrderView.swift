//
//  DetailOrderView.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 13/12/24.
//

import SwiftUI

struct DetailOrderView: View {
    let order: Order

    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 20) {
                Button {
                    // Kembali ke halaman sebelumnya
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                        .background{
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(.black.opacity(0.2))
                        }
                }
                Spacer()
            }
            Text("Order Details")
                .font(.title)
                .fontWeight(.bold)

            Text("Total: RM \(order.total, specifier: "%.2f")")
                .font(.headline)

            Text("Payment Method: \(order.paymentMethod)")
                .font(.subheadline)

            Text("Shipping Address: \(order.address)")
                .font(.subheadline)
                .padding(.bottom)
            
            Text("Products:")
                .font(.headline)
            
            ForEach(order.items, id: \ .id) { item in
                
                HStack {
                    // Jika ada URL atau nama gambar, gunakan `Image`.
                    // Untuk sementara tampilkan nama produk.
                    Text(item.productName)
                        .font(.body)
                        .fontWeight(.medium)
                    Spacer()
                    Text("x\(item.quantity)")
                    Text("RM \(item.price)")
                }
            }
            
//            ForEach(order.products) { item in
//                HStack {
//                    Image(item.product.ImgProduct)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 130, height: 130)
//                        .cornerRadius(15)
//                    Text(item.product.name)
//                    Spacer()
//                    Text("x\(item.quantity)")
//                }
//            }
            Spacer()
            
        }
        .padding()
        .navigationBarHidden(true)
    }
}

